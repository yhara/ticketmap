class Controller < Ramaze::Controller
  engine :Etanni
end

require __DIR__("./main.rb")
require __DIR__("./config.rb")
require __DIR__("./tickets.rb")
