# -*- encoding : utf-8 -*-
require 'inpay'
require 'inpay/checksum'
require 'inpay/notification'
require 'inpay/transaction'

class Hash
  
  def except(*keys)
    self.reject { |k,v| keys.include?(k || k.to_sym) }
  end
  
  def with(overrides = {})
    self.merge overrides
  end
  
  def only(*keys)
    self.reject { |k,v| !keys.include?(k || k.to_sym) }
  end

end
