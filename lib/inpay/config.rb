module Inpay
  module Config
    
    # flow urls
    def self.flow_urls
      Thread.current[:flow_urls] ||= {
        :test       => "https://test-secure.inpay.com/",
        :production => "https://secure.inpay.com/"
      }
    end
    def self.flow_url
      flow_urls[mode]
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
    
    # inpay server ips
    def self.server_ips= ips
      Thread.current[:server_ips] = [ips].flatten
    end
    def self.server_ips
      Thread.current[:server_ips] ||= []
    end
    
    # fields
    def self.keys_for action
      case action.to_sym
      when :create_invoice
        %w(merchant_id order_id amount currency order_text flow_layout secret_key)
      end
    end
    
  end
end