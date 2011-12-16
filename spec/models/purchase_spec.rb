require 'spec_helper'

describe Purchase do
  before do
    @it = Purchase.new
  end

  it "is valid with valid attributes" do
    @it.num_items = 5
    @it.item = mock_model(Item, valid?: true)
    @it.purchaser = mock_model(Purchaser, valid?: true)
    @it.valid?.should be_true
  end

  it "requires the number of items in the purchase" do
    @it.num_items = nil
    @it.valid?.should be_false
    @it.errors[:num_items].should_not be_empty
  end

  it "requires the number of items to be greater than zero" do
    @it.num_items = "foo"
    @it.valid?.should be_false
    @it.errors[:num_items].should_not be_empty

    @it.num_items = 0
    @it.valid?.should be_false
    @it.errors[:num_items].should_not be_empty
  end

  it "associates a purchaser and an item" do
    @it.respond_to?(:purchaser).should be_true
    @it.respond_to?(:item).should be_true
  end

  it "knows the purchaser's name" do
    @it.purchaser = mock_model(Purchaser, name: "Superman")
    @it.purchaser_name.should eq "Superman"
  end

  it "knows the items's description and price" do
    @it.item = mock_model(Item, description: "Lorem ipsum dolor.", price: 55.0)
    @it.item_description.should eq "Lorem ipsum dolor."
    @it.item_price.should eq 55.0
  end

  it "knows the item's merchant's name and address" do
    @it.item = mock_model(Item, merchant_name: "Foo Inc.", merchant_address: "123 Somewhere")
    @it.merchant_name.should eq "Foo Inc."
    @it.merchant_address.should eq "123 Somewhere"
  end

  it "requires a valid purchaser" do
    [nil, mock_model(Purchaser, valid?: false)].each do |bad_purchaser|
      @it.purchaser = bad_purchaser
      @it.valid?.should be_false
      @it.errors[:purchaser].should_not be_empty
    end
  end

  it "requires a valid item" do
    [nil, mock_model(Item, valid?: false)].each do |bad_item|
      @it.item = bad_item
      @it.valid?.should be_false
      @it.errors[:item].should_not be_empty
    end
  end

end