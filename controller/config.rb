class ConfigController < Controller
  map '/config'

  def board_size
    w = TicketMap.options[:board_width]
    h = TicketMap.options[:board_height]
    "(xy . (#{w} . #{h}))"
  end
end
