require 'spec/helper.rb'
load 'bin/tickets-server'

describe MainController do
  behaves_like :rack_test

  # index

  it 'shows start page' do
    get('/').status.should == 200
    last_response.should =~ /biwascheme\.js/
  end
end
