require 'spec_helper'

describe 'routing' do

  it 'GETs /import' do
    {get: '/import'}.should route_to('imports#new')
  end

  it 'POSTSs to /import' do
    {post: '/import'}.should route_to('imports#create')
  end

  it "GETs /" do
    {get: '/'}.should route_to('sessions#new')
  end

  it "GETs and POSTs to /auth/open_id/callback" do
    {post: '/auth/open_id/callback'}.should route_to(controller: 'sessions', action: 'create', provider: 'open_id')
  end

  it "GETs /logout" do
    {get: '/logout'}.should route_to('sessions#destroy')
  end

end