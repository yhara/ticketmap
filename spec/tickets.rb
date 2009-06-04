require 'spec/helper.rb'
load 'bin/tickets-server'

describe TicketsController do
  behaves_like :rack_test

  before do
    Ticket.delete
  end

  # create

  it 'creates new ticket' do
    lambda{
      get('/tickets/create')
    }.should.change{ Ticket.count }
  end

  # rename

  it 'renames a ticket' do
    get('/tickets/create').body =~ /\A\(id . (\d+)\)\z/
    id = $1
    id.should.not == nil

    post('/tickets/rename', :id => id, :title => "test1")
    last_response.body.should == "#t"
    Ticket.find(:id => id).title.should == "test1"
  end

  # list

#  it 'enumerates created tickets' do
#    get('/tickets/list').should =~ 
#  end
end
