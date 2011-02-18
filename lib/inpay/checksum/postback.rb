module Inpay
  module Checksum
    class Postback < Inpay::Checksum::Base
      
      private
        
        def keys
          Inpay::Config.keys_for(:postback)
        end
        
    end
  end
end