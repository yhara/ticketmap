require 'spec/helper.rb'
load 'bin/tickets-server'

describe Ticket do
  before do
    Ticket.all.destroy!
  end

  # instantiation

  it 'fills blank attributes' do
    t = Ticket.create
    t.importance.should.not == nil
    t.emergency.should.not == nil
    t.title.should.not == nil
    t.deleted.should == false
    t.timeouted.should == false
  end

  # shaking

  it 'detects when to shake' do 
    TicketMap.options[:shake_interval] = 0
    Ticket.needs_shaking?.should == true
  end

  it 'should move tickets' do
    Ticket.create(:emergency => 0, :importance => -10,  :title => "test1")
    Ticket.create(:emergency => 0, :importance => 10, :title => "test2")
    Ticket.shake!
    Ticket.first(:title => "test1").emergency.should > 0
    Ticket.first(:title => "test2").emergency.should < 0
  end
end
