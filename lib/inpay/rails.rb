require 'active_support'
require File.join(File.dirname(__FILE__), 'helpers', '/rails')

ActionView::Base.send(:include, Inpay::Helpers::Common)
ActionView::Base.send(:include, Inpay::Helpers::Rails)