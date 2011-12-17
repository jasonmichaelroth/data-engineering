require 'spec_helper'

describe 'routing' do

  it 'GETs /import' do
    {get: '/import'}.should route_to('imports#new')
  end

  it 'POSTSs to /import' do
    {post: '/import'}.should route_to('imports#create')
  end

end