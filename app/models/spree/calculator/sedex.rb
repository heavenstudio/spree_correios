module Spree
  class Calculator::SEDEX < Calculator::CorreiosBaseCalculator
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
        '04162'
      else
        '04014'
      end
    end
  end
end
