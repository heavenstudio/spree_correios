module Spree
  module Calculator::Shipping
    autoload :CorreiosBaseCalculator, 'app/models/spree/shipping/correios_base_calculator'
    autoload :PAC, 					  'app/models/spree/shipping/pac'
    autoload :SEDEX,				  'app/models/spree/shipping/sedex'
    autoload :SEDEX10,			  	  'app/models/spree/shipping/sedex10'
  end
end