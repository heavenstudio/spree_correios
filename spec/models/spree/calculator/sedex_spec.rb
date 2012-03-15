require 'spec_helper'
require 'open-uri'

describe Spree::Calculator::SEDEX do
  before do
    @sedex = Spree::Calculator::SEDEX.new
  end

  it_behaves_like "correios calculator"
  
  it "should have a description" do
    Spree::Calculator::SEDEX.description.should == "SEDEX"
  end
  
  context "without a token and password" do
    it "should have a shipping method of :pac" do
      @sedex.shipping_method.should == :sedex
    end
    
    it "should have a shipping code of 40010" do
      @sedex.shipping_code.should == 40010
    end
  end

  context "with a token and password" do
    before do
      @sedex.preferred_token = "some token"
      @sedex.preferred_password = "some password"    
    end
    
    it "should have a shipping method of :pac_com_contrato" do
      @sedex.shipping_method.should == :sedex_com_contrato_1
    end
    
    it "should have a shipping code of 40096" do
      @sedex.shipping_code.should == 40096
    end
  end
end