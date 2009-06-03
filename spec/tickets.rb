require 'spec/helper.rb'
load 'bin/tickets-server'

describe TicketsController do
  behaves_like :rack_test

  # create

  it 'creates new ticket' do
    lambda{
      get('/tickets/create')
    }.should.change{ Ticket.count }
  end
end
