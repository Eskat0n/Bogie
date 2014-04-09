class Anime
  attr_reader :url, :title, :episodes

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open @url)

    @title = @doc.at_css('.content-block-title h2 a').text
    .split('/').last.strip

    @episodes = @doc.css('.accordion h3')
    .select { |item| not item.at_css('span').nil? }
    .map { |item| Episode.create(item, self) }
  end

  def get_episodes(type, provider)
    @episodes.select do |ep|
      ep.type == type.to_sym and ep.provider == provider.to_sym
    end
  end
end