module Inpay
  module Config
    
    # post url
    def self.post_urls
      Thread.current[:post_urls] ||= {
        :test       => "https://test-secure.inpay.com/",
        :production => "https://secure.inpay.com/"
      }
    end
    def self.post_url
      post_urls[mode]
    end
    
    # current operation mode
    def self.mode= new_mode
      new_mode = new_mode.to_sym
      
      unless [:test, :production].include?(new_mode)
        raise ArgumentError.new("Inpay::Config.mode should be either :test or :production (you tried to set it as :#{ new_mode })")
      end
      
      Thread.current[:mode] = new_mode
    end
    def self.mode
      Thread.current[:mode] ||= :test
    end
    
  end
end