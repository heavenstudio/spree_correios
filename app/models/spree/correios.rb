module Spree
  module Calculator::Shipping
    autoload :CorreiosBaseCalculator, 'spree/shipping/correios_base_calculator'
    autoload :PAC, 					  'spree/shipping/pac'
    autoload :SEDEX,				  'spree/shipping/sedex'
    autoload :SEDEX10,			  	  'spree/shipping/sedex10'
  end
end