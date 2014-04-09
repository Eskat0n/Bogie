class Episode
  attr_reader :number, :name, :type, :video_id

  def self.create(item, anime)
    number = item.text.match(/^(\d+)/)[1].to_i
    name = item.children.first.text.match(/^\d+\.?\s*(.+)/)[1].chop

    type = self.get_type(item.css('span').first.text)

    url_element_id = item[:id].match(/(\d+)$/)[1]
    url_element = item.document.at_css("#an_ul#{url_element_id}")

    case url_element.text
      when /myvi\.ru/ then MyviEpisode.new(anime, number, name, type, url_element.text)
      when /sibnet\.ru/ then SibnetEpisode.new(anime, number, name, type, url_element.text)
    end
  end

  def initialize(anime, number, name, type)
    @anime_title, @number, @name, @type = anime.title, number, name, type
  end

  def download!
    raise "Can't download non-specific episode"
  end

  private
  def self.get_type(type)
    case type
      when /[Сс]убтитры/ then
        :sub
      else
        :dub
    end
  end
end