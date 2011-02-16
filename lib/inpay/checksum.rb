# -*- encoding : utf-8 -*-
require 'cgi'
require 'digest/md5'

class Inpay::Checksum
  # checksum parameter keys
  PARAMS = %w(merchant_id order_id amount currency order_text flow_layout secret_key)
  
  def initialize params
    @params = params
  end
  
  # build a checksum from given parameters
  def result
    Digest::MD5.hexdigest(param_string)
  end
  
  # build a param_string from given parameters
  def param_string
    PARAMS.collect do |p|
      if p == 'amount'
        value = sprintf('%.2f', @params[:amount].to_f)
      else
        value = @params[:"#{ p }"]
      end
      
      "#{ p }=#{ CGI.escape(value.to_s) }"
      
    end.join('&')
  end
  
end
