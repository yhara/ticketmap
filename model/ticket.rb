class Ticket
  include DataMapper::Resource

  # properties

  property :id, Serial
  property :importance, Integer 
  property :emergency, Integer
  property :title, String
  property :deleted, Boolean
  property :timeouted, Boolean

  # validations

  before :save do
    self.importance ||= 0
    self.emergency ||= 0
    self.title ||= ""
    self.deleted = false if self.deleted == nil
    self.timeouted = false if self.timeouted == nil
  end

  # class methods
  
  @@last_shook = Time.now

  def self.needs_shaking?
    (Time.now - @@last_shook) > TicketMap.options[:shake_interval]*60*60
  end

  def self.shake!
    Ticket.all.each do |ticket|
      pos = ticket.emergency
      dir = (ticket.importance < 0 ? 1 : -1)
      newpos = pos + TicketMap.options[:shake_distance] * dir
      if newpos > (TicketMap.options[:board_width] / 2)
        newpos = (TicketMap.options[:board_width] / 2)
      end

      ticket.emergency = newpos if newpos != pos
      if newpos < -(TicketMap.options[:board_width] / 2)
        ticket.deleted = true
        ticket.timeouted = true
      end
      ticket.save
    end
    @@last_shook = Time.now
  end
end
