#!/usr/bin/env ruby
require 'optparse'
require 'rubygems'
require 'ruby-station'; RubyStation.parse_argv
require 'ramaze'

module TicketMap
  include Innate::Optioned
  VERSION = File.read(__DIR__("VERSION"))

  options.dsl do
    o "Path of config file", 
      :config, File.expand_path("~/.ticketmap.rb") 
#    o "Path of database file",
#      :db, File.expand_path("~/.ticketmap.db")
#    o "Port number", 
#      :port, 7007
    o "Interval to automatically move tickets (hours)",
      :shake_interval, 24
    o "Distance to automatically move tickets (pixels)",
      :shake_distance, 8
    o "Width of the board (pixels)",
      :board_width, 600
    o "Height of the board (pixels)",
      :board_height, 600
  end
end

$LOAD_PATH.unshift __DIR__("./")
require 'controller/init.rb'
require 'model/init.rb'

conf = TicketMap.options[:config]
if File.exist?(conf)
  Ramaze::Log.info("Loading config file: #{conf}")
  load conf
end

Ramaze.start :port => RubyStation.port,
             :root => __DIR__('./')
