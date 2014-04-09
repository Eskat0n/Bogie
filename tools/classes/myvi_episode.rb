require_relative 'episode'

class MyviEpisode < Episode
  def initialize(anime, number, name, type, url)
    super(anime, number, name, type)
  end

  def provider
    :myvi
  end

  def download!

  end
end