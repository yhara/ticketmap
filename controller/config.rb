class ConfigController < Controller
  map '/config'

  def board_size
    "(xy . (#{Tickets::Config::BOARD_WIDTH} . #{Tickets::Config::BOARD_HEIGHT}))"
  end
end
