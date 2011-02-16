module Inpay
  module Helpers
    module Common
      
      def inpay_setup
        
      end
      
      def inpay_fields fields = {}
        fields.collect do |key, value|
          %Q{<input type="hidden" name="#{ key }" value="#{ value }" />}
        end.join("\n")
      end
      
    end
  end
end