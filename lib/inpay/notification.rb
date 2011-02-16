# -*- encoding : utf-8 -*-
module Inpay
  class NoDataError < StandardError; end
  
  class Notification
    attr_accessor :params
    attr_accessor :raw

    def initialize(post)
      raise NoDataError if post.to_s.blank?

      @params  = {}
      @raw     = ''

      parse(post)
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
    
    # check if the request is genuine
    def genuine?
      
    end


    private

      def status
        @status ||= (params['invoice_status'] ? params['invoice_status'].to_sym : nil)
      end

      # Take the posted data and move the relevant data into a hash
      def parse(post)
        @raw = post
        self.params = Rack::Utils.parse_query(post)

        # Rack allows duplicate keys in queries, we need to use only the last value here
        self.params.each do |k,v|
          self.params[k] = v.last if v.is_a?(Array)
        end
      end
  end
  
end
