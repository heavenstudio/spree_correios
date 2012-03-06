require 'spec_helper'

describe Spree::Correios::SEDEX do
  it_behaves_like "correios calculator"
  
  it "should have a description" do
    Spree::Correios::SEDEX.description.should == "SEDEX"
  end
end