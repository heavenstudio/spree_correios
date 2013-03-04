module Spree
  class Calculator::SEDEX10 < Calculator::CorreiosBaseCalculator

    attr_accessible :preferred_zipcode, :preferred_token, :preferred_password, :preferred_declared_value, :preferred_receipt_notification, :preferred_receive_in_hands
    
    def self.description
      "SEDEX 10"
    end
    
    def shipping_method
      :sedex_10
    end
    
    def shipping_code
      40215
    end
  end
end
