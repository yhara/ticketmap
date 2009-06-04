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
      get('/tickets/create').should =~ /\A\(id . (\d+)\)\z/
    }.should.change{ Ticket.count }
  end
  
  # list

  it 'enumerates created tickets' do
    Ticket.create(:title => "test1")
    Ticket.create(:title => "test2")

    get('/tickets/list')

    last_response.should =~ /test1/
    last_response.should =~ /test2/
  end
  
  # list

  it 'moves a ticket' do
    id = get('/tickets/create').match(/\A\(id . (\d+)\)\z/)[1]

    post('/tickets/move', :id => id, :x => 10, :y => -10)
    last_response.body.should == "#t"

    Ticket.first.emergency.should == 10
    Ticket.first.importance.should == -10
  end

  # rename

  it 'renames a ticket' do
    id = get('/tickets/create').match(/\A\(id . (\d+)\)\z/)[1]

    post('/tickets/rename', :id => id, :title => "test1")
    last_response.body.should == "#t"

    Ticket.first.title.should == "test1"
  end

  # delete
  
  it 'deletes a ticket' do
    id = get('/tickets/create').match(/\A\(id . (\d+)\)\z/)[1]

    post('/tickets/delete', :id => id)
    last_response.body.should == "#t"

    Ticket.first.deleted.should == true
  end

end
