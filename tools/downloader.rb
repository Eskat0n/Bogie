require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'iron_mq'
require 'awesome_print'

require_relative 'classes/anime'
require_relative 'classes/episode'
require_relative 'classes/myvi_episode'
require_relative 'classes/sibnet_episode'

ironmq = IronMQ::Client.new

queue = ironmq.queue('download_tasks')
queue.poll do |message|
  task = JSON.parse(message.body, symbolize_names: true)

  ap task

  anime = Anime.new task[:url]
  episodes = anime.get_episodes task[:type], task[:provider]

  ap episodes
end

