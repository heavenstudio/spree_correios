module Spree
  class Calculator::SEDEX < Calculator::CorreiosBaseCalculator

    attr_accessible :preferred_zipcode, :preferred_token, :preferred_password, :preferred_declared_value, :preferred_receipt_notification, :preferred_receive_in_hands

    def self.description
      "SEDEX"
    end
    
    def shipping_method
      if preferred_token.present? && preferred_password.present?
        :sedex_com_contrato_1
      else
        :sedex
      end
    end
    
    def shipping_code
      if has_contract?
        40096
      else
        40010
      end
    end
  end
end
