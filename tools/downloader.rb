require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'iron_mq'

require 'log4r'
require 'log4r/yamlconfigurator'
require 'awesome_print'

require_relative 'classes/anime'
require_relative 'classes/episode'
require_relative 'classes/myvi_episode'
require_relative 'classes/sibnet_episode'

include Log4r

logger_config = File.join(File.dirname(__FILE__), 'log4r.yml')
YamlConfigurator.load_yaml_file logger_config

logger = Logger.new('default')
ironmq = IronMQ::Client.new

logger.info 'Bogie download daemon started'

queue = ironmq.queue('download_tasks')
queue.poll do |message|
  task = JSON.parse(message.body, symbolize_names: true)

  ap task

  anime = Anime.new task[:url]
  episodes = anime.get_episodes task[:type], task[:provider]

  ap episodes
end

logger.info 'Bogie download daemon stopped'