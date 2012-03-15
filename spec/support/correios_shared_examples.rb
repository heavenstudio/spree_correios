shared_examples_for "correios calculator" do
  before { @calculator = subject.class.new }

  it "should have preferences" do
    @calculator.preferences.keys.should include(:zipcode, :declared_value, :receipt_notification, :receive_in_hands, :token, :password)
  end

  it "delcared value should default to false" do
    @calculator.preferred(:declared_value).should == false
  end
  
  it "receipt notification should default to false" do
    @calculator.preferred(:receipt_notification).should == false
  end

  it "receive in hands should default to false" do
    @calculator.preferred(:receive_in_hands).should == false
  end
  
  it "should have a contract if both token and password are given" do
    @calculator.should_not have_contract
    @calculator.preferred_token = "some token"
    @calculator.preferred_password = "some password"
    @calculator.should have_contract
  end
  
  context "compute" do
    def get_correios_price_and_value_for(url)
      doc = Nokogiri::XML(open(url))
      price = doc.css("Valor").first.content.sub(/,(\d\d)$/, '.\1').to_f
      prazo = doc.css("PrazoEntrega").first.content.to_i
      return price, prazo
    end
    
    before do
      items = [double(weight: 1, length: 20, width: 15, height: 5)]
      @order = double("Order", line_items: items, amount: BigDecimal("2000,00"), ship_address: stub(zipcode: "72151613"))
      @calculator.preferred_zipcode = "71939360"
    end
    
    it "should calculate shipping cost and delivery time" do
      if @calculator.class.name != "Spree::Calculator::CorreiosBaseCalculator"
        price, prazo = get_correios_price_and_value_for("http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=71939360&sCepDestino=72151613&nVlPeso=1&nCdFormato=1&nVlComprimento=20&nVlAltura=5&nVlLargura=15&sCdMaoPropria=n&nVlValorDeclarado=0&sCdAvisoRecebimento=n&nCdServico=#{@calculator.shipping_code}&nVlDiametro=0&StrRetorno=xml")

        @calculator.compute(@order).should == price
        @calculator.delivery_time.should == prazo
      end
    end
    
    it "should change price according to declared value" do
      if @calculator.class.name != "Spree::Calculator::CorreiosBaseCalculator"
        price, prazo = get_correios_price_and_value_for("http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=71939360&sCepDestino=72151613&nVlPeso=1&nCdFormato=1&nVlComprimento=20&nVlAltura=5&nVlLargura=15&sCdMaoPropria=n&nVlValorDeclarado=2000,00&sCdAvisoRecebimento=n&nCdServico=#{@calculator.shipping_code}&nVlDiametro=0&StrRetorno=xml")

        @calculator.preferred_declared_value = true
        @calculator.compute(@order).should == price
      end
    end
    
    it "should change price according to in hands" do
      if @calculator.class.name != "Spree::Calculator::CorreiosBaseCalculator"
        price, prazo = get_correios_price_and_value_for("http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=71939360&sCepDestino=72151613&nVlPeso=1&nCdFormato=1&nVlComprimento=20&nVlAltura=5&nVlLargura=15&sCdMaoPropria=s&nVlValorDeclarado=0&sCdAvisoRecebimento=n&nCdServico=#{@calculator.shipping_code}&nVlDiametro=0&StrRetorno=xml")

        @calculator.preferred_receive_in_hands = true
        @calculator.compute(@order).should == price
      end
    end

    it "should change price according to receipt notification" do
      if @calculator.class.name != "Spree::Calculator::CorreiosBaseCalculator"
        price, prazo = get_correios_price_and_value_for("http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=71939360&sCepDestino=72151613&nVlPeso=1&nCdFormato=1&nVlComprimento=20&nVlAltura=5&nVlLargura=15&sCdMaoPropria=n&nVlValorDeclarado=0&sCdAvisoRecebimento=s&nCdServico=#{@calculator.shipping_code}&nVlDiametro=0&StrRetorno=xml")

        @calculator.preferred_receipt_notification = true
        @calculator.compute(@order).should == price
      end
    end    
  end
end