require 'spec_helper'

describe 'authentication' do

  # Can VCR and/or fakeweb mock up this kind of authentication?
  # TODO: Find a way to mock login in and out via openid
  it "logs in via OpenID"
  it "logs the user out"

  it "handles failed login attempts" do
    visit root_path
    click_on 'OpenID'
    fill_in 'OpenID Identifier', with: 'foobar'
    click_on 'Connect'

    # Should be on the import page
    page.should have_content 'failed'
    current_path.should eq auth_failure_path
  end

end