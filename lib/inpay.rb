# -*- encoding : utf-8 -*-
require 'rubygems'
require 'net/http'

require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/string/inflections'

require 'inpay/config'
require 'inpay/rails'
require 'inpay/core_extensions'
require 'inpay/postback'
require 'inpay/checksum'
require 'inpay/checksum/create_invoice'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Inpay
  
  # shortcut for checksum calculation
  def self.checksum action, params
    unless %w(create_invoice).include?(action.to_s)
      raise ArgumentError.new("'#{ action }' is not a valid action")
    end
    
    checksum = "Inpay::Checksum::#{ action.to_s.classify }".constantize.new(params)
    checksum.result
  end
  
end