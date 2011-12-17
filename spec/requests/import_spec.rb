require 'spec_helper'

describe "uploading a file" do

  let(:good_tab_file)    { File.join(Rails.root, 'spec/fixtures/good_data.tab') }
  let(:bad_tab_file)     { File.join(Rails.root, 'spec/fixtures/bad_data.tab') }
  let(:invalid_tab_file) { File.join(Rails.root, 'spec/fixtures/rails.png') }

  it "uploads and processes a tab file" do
    visit new_import_path
    attach_file 'file', good_tab_file
    click_button 'Import'

    page.should have_content "success"
    page.should have_content "gross revenue was $95"

    # Verify the data from the fixture tab file

    Purchaser.count.should eq 3
    Purchaser.where(name: 'Snake Plissken').count.should eq 1
    Purchaser.where(name: 'Amy Pond').count.should eq 1
    Purchaser.where(name: 'Marty McFly').count.should eq 1

    Item.count.should eq 3
    Item.where(description: '$10 off $20 of food', price: 10.0).count.should eq 1
    Item.where(description: '$30 of awesome for $10', price: 10.0).count.should eq 1
    Item.where(description: '$20 Sneakers for $5', price: 5.0).count.should eq 1

    Merchant.count.should eq 3
    Merchant.where(name: "Bob's Pizza", address: '987 Fake St').count.should eq 1
    Merchant.where(name: "Tom's Awesome Shop", address: '456 Unreal Rd').count.should eq 1
    Merchant.where(name: "Sneaker Store Emporium", address: '123 Fake St').count.should eq 1

  end

  it "complains when no file is uploaded" do
    visit new_import_path
    # don't attach a file
    click_button 'Import'

    page.should have_content 'file is required'
  end

  it "complains when an invalid file is uploaded" do
    visit new_import_path
    attach_file 'file', invalid_tab_file
    click_button 'Import'

    page.should have_content 'not a tab deliminated file'
  end

  it "complains when bad data is uploaded" do
    visit new_import_path
    attach_file 'file', bad_tab_file
    click_button 'Import'

    page.should have_content 'has an invalid row'
  end

end