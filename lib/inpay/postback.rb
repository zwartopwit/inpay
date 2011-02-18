# -*- encoding : utf-8 -*-
module Inpay
  class NoDataError < StandardError; end
  class InvalidIPError < StandardError; end
  class ForgedRequestError < StandardError; end
  
  class Postback
    attr_accessor :raw, :params, :error
    
    def initialize request, secret_key
      raise NoDataError if request.nil? || request.raw_post.to_s.blank?
      
      @secret_key = secret_key
      @remote_ip  = request.remote_ip
      @params     = {}
      @raw        = ''

      parse(request.raw_post)
    end

    # Transaction statuses
    def pending?
      status == :pending
    end

    def sum_too_low?
      status == :sum_too_low
    end

    def approved?
      status == :approved
    end

    def cancelled?
      status == :cancelled
    end

    def refunded?
      status == :refunded?
    end

    def refund_pending?
      status == :refund_pending
    end

    def error?
      status == :error
    end

    def method_missing(method, *args)
      params[method.to_s] || super
    end
    
    # acknowledge postback data
    def genuine?
      self.error = InvalidIPError     unless Inpay::Config.server_ips.include?(@remote_ip)
      self.error = ForgedRequestError unless Inpay.checksum(:postback, params) == params[:checksum]
      
      error.nil?
    end
    
    private

      def status
        @status ||= (params[:invoice_status] ? params[:invoice_status].to_sym : nil)
      end

      # Take the posted data and move the relevant data into a hash
      def parse post
        @raw = post
        self.params = Rack::Utils.parse_query(post).symbolize_keys

        # Rack allows duplicate keys in queries, we need to use only the last value here
        params.each do |k, v|
          self.params[k] = v.last if v.is_a?(Array)
        end
        
        # add secret key
        params[:secret_key] = @secret_key
      end
  end
  
end
