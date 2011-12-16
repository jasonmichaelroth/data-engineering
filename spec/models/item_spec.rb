require 'spec_helper'

describe Item do
  before do
    @it = Item.new
  end

  it "is valid with valid attributes" do
    @it.description = "Lorem ipsum dolor.";
    @it.price = 55.0
    @it.valid?.should be_true
  end

  it "requires a description" do
    @it.description = nil
    @it.valid?.should be_false
    @it.errors[:description].should_not be_empty
  end

  it "requires a price" do
    @it.price = nil
    @it.valid?.should be_false
    @it.errors[:price].should_not be_empty
  end

  it "requires the price to be a number greater than zero" do
    @it.price = "foo"
    @it.valid?.should be_false
    @it.errors[:price].should_not be_empty

    @it.price = 0
    @it.valid?.should be_false
    @it.errors[:price].should_not be_empty
  end

  it "belongs to a merchant" do
    @it.respond_to?(:merchant).should be_true
  end

  it "knows the merchant's name and address" do
    @it.merchant = mock_model(Merchant, name: "Foo Bar", address: "123 Somewhere")
    @it.merchant_address.should eq "123 Somewhere"
    @it.merchant_name.should eq "Foo Bar"
  end

end