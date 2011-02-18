# -*- encoding : utf-8 -*-
require 'cgi'
require 'digest/md5'

module Inpay
  module Checksum
    
    # checksum base class should only be used as a subclass
    class Base
      
      def initialize params
        @params = params
      end
      
      # build a checksum from given parameters
      def result
        @_result ||= Digest::MD5.hexdigest(param_string)
      end
      
      # build a param_string from given parameters
      def param_string
        keys.collect do |p|
          "#{ p }=#{ CGI.escape(@params[:"#{ p }"].to_s) }"
        end.join('&')
      end
      
    end
  end
end