class TicketsController < Controller
  map '/tickets'

  def create
    ticket = Ticket.new
    ticket.save

    "(id . #{ticket.id})"
  end

  def list
    tickets = Ticket.all(:deleted => false)

    '(' +
    tickets.map{|ticket|
      "(#{ticket.id} #{ticket.title.inspect} #{ticket.emergency} #{ticket.importance})"
    }.join(' ') +
    ')'
  end

  def move
    raise "must be via POST" unless request.post?
    ticket = Ticket.get(request["id"])
    raise "ticket not found" unless ticket

    ticket.update_attributes(:emergency => request["x"],
                             :importance => request["y"])
    "#t"
  end

  def rename
    raise "must be via POST" unless request.post?
    ticket = Ticket.get(request["id"])
    raise "ticket not found" unless ticket

    ticket.update_attributes(:title => request["title"])
    "#t"
  end

  def delete
    raise "must be via POST" unless request.post?
    ticket = Ticket.get(request["id"])
    raise "ticket not found" unless ticket

    ticket.update_attributes(:deleted => true)
    "#t"
  end
end

