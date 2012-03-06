require 'spec_helper'

describe Spree::Correios::PAC do
  it_behaves_like "correios calculator"
  
  it "should have a description" do
    Spree::Correios::PAC.description.should == "PAC"
  end  
end
