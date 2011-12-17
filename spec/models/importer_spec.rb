require 'spec_helper'

describe Importer do
  before do
    @it = Importer.new
  end

  it "reads and writes the tab file" do
    @it.tab_file = "/path/to/something"
    @it.tab_file.should eq "/path/to/something"
  end

  it "requires a tab file" do
    @it.tab_file = nil
    @it.valid?.should be_false
    @it.errors[:tab_file].should_not be_empty
  end

  describe '#import' do

    context "with no file" do
      before do
        @file = "/path/to/nowhere.png"
      end

      it "returns false and sets an error" do
        @it.import(@file).should be_false
        @it.errors[:tab_file].should_not be_empty
      end

      it "has no gross revenue" do
        @it.import(@file).should be_false
        @it.gross_revenue.should be_nil
      end
    end

    context "with an invalid file (e.g. an image)" do
      before do
        @file = File.join(Rails.root, 'spec/fixtures/rails.png')
      end

      it "returns false and sets an error" do
        @it.import(@file).should be_false
        @it.errors[:tab_file].should_not be_empty
      end

      it "saves nothing" do
        @it.import(@file).should be_false
        Purchaser.count.should be_zero
        Merchant.count.should be_zero
        Item.count.should be_zero
        Purchase.count.should be_zero
      end

      it "has no gross revenue" do
        @it.import(@file).should be_false
        @it.gross_revenue.should be_nil
      end
    end

    context "with a valid file with bad data" do
      before do
        @file = File.join(Rails.root, 'spec/fixtures/bad_data.tab')
      end

      it "returns false and set an error" do
        @it.import(@file).should be_false
        @it.errors[:tab_file].should_not be_empty

        # Check that the error message notifies us of the correct error line
        @it.errors[:tab_file].to_s.should match /at line 2/
      end

      it "saves nothing" do
        @it.import(@file).should be_false
        Purchaser.count.should be_zero
        Merchant.count.should be_zero
        Item.count.should be_zero
        Purchase.count.should be_zero
      end

      it "has no gross revenue" do
        @it.import(@file).should be_false
        @it.gross_revenue.should be_nil
      end
    end

    context "with a valid file with good data" do
      before do
        @file = File.join(Rails.root, 'spec/fixtures/good_data.tab')
      end

      it "returns true" do
        @it.import(@file).should be_true
      end

      it "saves some records" do
        @it.import(@file).should be_true
        Purchaser.count.should_not be_zero
        Merchant.count.should_not be_zero
        Item.count.should_not be_zero
        Purchase.count.should_not be_zero
      end

      it "knows the gross revenue" do
        @it.import(@file).should be_true
        @it.gross_revenue.should eq 95
      end
    end

  end

end