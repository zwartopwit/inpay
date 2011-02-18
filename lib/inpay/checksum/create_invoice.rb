module Inpay
  module Checksum
    class CreateInvoice < Inpay::Checksum::Base
      
      private
        
        def keys
          Inpay::Config.keys_for(:create_invoice)
        end
        
    end
  end
end