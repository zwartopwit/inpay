# -*- encoding : utf-8 -*-
require 'rubygems'
require 'net/http'
require 'active_support/core_ext/hash/conversions'
require 'inpay/core_extensions'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Inpay
  
  def self.checksum params
    Inpay::Checksum.new(params).result
  end
  
end
