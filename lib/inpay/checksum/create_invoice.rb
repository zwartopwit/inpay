module Inpay
  module Checksum
    class CreateInvoice < Inpay::Checksum::Base
      
      private
        
        def keys
          %w(merchant_id order_id amount currency order_text flow_layout secret_key)
        end
        
    end
  end
end