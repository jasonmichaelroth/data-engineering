require 'spec_helper'

describe Merchant do
  before do
    @it = Merchant.new
  end

  it "is valid with valid attributes" do
    @it.name = "Foo bar"
    @it.address = "123 Somewhere"
    @it.valid?.should be_true
  end

  it "requires a name" do
    @it.name = nil
    @it.valid?.should be_false
    @it.errors[:name].should_not be_empty
  end

  it "requires an address" do
    @it.address = nil
    @it.valid?.should be_false
    @it.errors[:address].should_not be_empty
  end

  it "associates items" do
    @it.respond_to?(:items).should be_true
  end

end