class MainController < Controller
  map '/'

  def index
    Ticket.shake! if Ticket.needs_shaking?
  end

  def track
    @tickets = Ticket.filter(:deleted => true).reverse_order(:id)
  end
end
