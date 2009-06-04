require 'spec/helper.rb'
load 'bin/tickets-server'

describe ConfigController do
  behaves_like :rack_test

  # board_size

  it 'returns board size' do
    get('/config/board_size').status.should == 200
    last_response.should =~ /\(xy . \(\d+ . \d+\)\)/
  end
end
