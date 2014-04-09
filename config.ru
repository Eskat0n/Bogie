require 'rubygems'
require 'bundler'

Bundler.require

require './app/application'

map '/' do
  run Bogie
end
