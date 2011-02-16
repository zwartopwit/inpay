# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'inpay/checksum'

describe Inpay::Checksum do
  
  describe "calculate checksum according to values in API manual" do
    before(:each) do
      init_checksum
    end
    
    it "builds an url encoded string of params" do
      @checksum.param_string.should == 'merchant_id=1&order_id=123&amount=100.07&currency=USD&order_text=on+p%C3%A5+x.y-z&flow_layout=multi_page&secret_key=sec'
    end

    it "generates a md5 key" do
      @checksum.result.should == 'd861859457208e4b40777b85502b0fcd'
    end
  end
  
  describe "calculate checksum with Canadian dollars" do
    before(:each) do
      init_checksum(
        :merchant_id => '100',
        :order_id    => '987654',
        :amount      => 20,
        :currency    => :CAD,
        :order_text  => 'Order #987654 ad mysite.com',
        :flow_layout => :multi_page,
        :secret_key  => 'foo'
      )
    end
    
    it "builds an url encoded string of params" do
      @checksum.param_string.should == 'merchant_id=100&order_id=987654&amount=20&currency=CAD&order_text=Order+%23987654+ad+mysite.com&flow_layout=multi_page&secret_key=foo'
    end

    it "generates a md5 key" do
      @checksum.result.should == '012d5ffd5bac11fa051bcd42f648a4d7'
    end
  end
  
  private
    
    def init_checksum options = {}
      @checksum = Inpay::Checksum.new({
        :merchant_id => 1,
        :order_id    => 123,
        :amount      => 100.07,
        :currency    => :USD,
        :order_text  => "on på x.y-z",
        :flow_layout => :multi_page,
        :secret_key  => 'sec'
      }.update(options))
    end
end
