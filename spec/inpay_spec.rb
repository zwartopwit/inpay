# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'inpay'

describe Inpay do
  
  describe "#checksum" do
    it "should generate a valid checksum for 'create_invoice'" do
      Inpay.checksum(:create_invoice, create_invoice_params).should == '012d5ffd5bac11fa051bcd42f648a4d7'
    end
  end
  
  private
    
    def create_invoice_params
      {
        :merchant_id => '100',
        :order_id    => '987654',
        :amount      => 20,
        :currency    => :CAD,
        :order_text  => 'Order #987654 ad mysite.com',
        :flow_layout => :multi_page,
        :secret_key  => 'foo'
      }
    end
  
end
