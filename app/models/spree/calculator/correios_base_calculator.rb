module Spree
  class Calculator::CorreiosBaseCalculator < Calculator
    preference :zipcode, :string
    preference :token, :string
    preference :password, :password
    preference :declared_value, :boolean, default: false
    preference :receipt_notification, :boolean, default: false
    preference :receive_in_hands, :boolean, default: false
    
    attr_reader :delivery_time
    
    def compute(object)
      compute_delivery_price_and_time(object)
    end
    
    def compute(object)
      return unless object.present? and object.line_items.present?
      
      package = ::Correios::Frete::Pacote.new
      object.line_items.map do |item|
        package_item = ::Correios::Frete::PacoteItem.new(peso: item.weight, comprimento: item.length, largura: item.width, altura: item.height)
        package.add_item(package_item)
      end
      
      calculator = ::Correios::Frete::Calculador.new do |c| 
        c.cep_origem = preferred_zipcode
        c.cep_destino = object.ship_address.zipcode
        c.encomenda = package
        c.valor_declarado = object.amount.to_f if prefers?(:declared_value)
        c.mao_propria = prefers?(:receive_in_hands)
        c.aviso_recebimento = prefers?(:receipt_notification)
        c.codigo_empresa = preferred_token if preferred_token.present?
        c.senha = preferred_password if preferred_password.present?
      end
      
      webservice = calculator.calculate(shipping_method)
      raise webservice.msg_erro if webservice.erro?
      @delivery_time = webservice.prazo_entrega
      webservice.valor
    end
    
    def has_contract?
      preferred_token.present? && preferred_password.present?
    end
  end
end