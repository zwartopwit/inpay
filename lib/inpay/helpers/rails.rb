module Inpay
  module Helpers
    module Rails
      
      # nice option for form url
      def inpay_post_url
        Inpay::Config.post_url
      end
      
    end
  end
end