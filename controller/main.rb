class MainController < Controller
  map '/'

  def index
    Ticket.shake! if Ticket.needs_shaking?
  end

  def track
    @tickets = Ticket.all(:deleted => true, :order => [:id.desc])
  end
end
