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
end