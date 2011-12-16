require 'spec_helper'

describe Purchaser do
  before do
    @it = Purchaser.new
  end

  it "is valid with valid attributes" do
    @it.name = "Foo bar"
    @it.valid?.should be_true
  end

  it "requires a name" do
    @it.name = nil
    @it.valid?.should be_false
    @it.errors[:name].should_not be_empty
  end

end