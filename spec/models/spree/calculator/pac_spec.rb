require 'spec_helper'

describe Spree::Calculator::PAC do
  before do
    @pac = Spree::Calculator::PAC.new
  end

  it_behaves_like "correios calculator"
  
  it "should have a description" do
    Spree::Calculator::PAC.description.should == "PAC"
  end
  
  context "without a token and password" do
    it "should have a shipping method of :pac" do
      @pac.shipping_method.should == :pac
    end
    
    it "should have a shipping code of 41106" do
      @pac.shipping_code.should == 41106
    end
  end

  context "with a token and password" do
    before do
      @pac.preferred_token = "some token"
      @pac.preferred_password = "some password"
    end
    
    it "should have a shipping method of :pac_com_contrato" do
      @pac.shipping_method.should == :pac_com_contrato
    end
    
    it "should have a shipping code of 41068" do
      @pac.shipping_code.should == 41068
    end
  end
end
