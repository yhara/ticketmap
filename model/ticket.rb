require 'sequel'
require 'sequel/extensions/migration'
Sequel::Model.plugin(:schema) # for table_exists?

$db = Sequel.sqlite(TicketMap.options[:db])

class Ticket < Sequel::Model(:tickets)
  @@last_shook = Time.now

  def self.needs_shaking?
    (Time.now - @@last_shook) > TicketMap.options[:shake_interval]*60*60
  end

  def self.shake!
    Ticket.each do |ticket|
      pos = ticket.emergency
      dir = (ticket.importance < 0 ? 1 : -1)
      newpos = pos + TicketMap.options[:shake_distance] * dir
      if newpos > (TicketMap.options[:board_width] / 2)
        newpos = (TicketMap.options[:board_width] / 2)
      end

      ticket.update(:emergency => newpos) if newpos != pos
      if newpos < -(TicketMap.options[:board_width] / 2)
        ticket.update(:deleted => true, :timeouted => true)
      end
    end
    @@last_shook = Time.now
  end
end

unless Ticket.table_exists?
  migration_dir = File.expand_path("../db/migrate/",
                                   File.dirname(__FILE__))
  Sequel::Migrator.apply($db, migration_dir)
end
