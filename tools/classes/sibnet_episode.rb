require_relative 'episode'

class SibnetEpisode < Episode
  def initialize(anime, number, name, type, url)
    super(anime, number, name, type)
    @video_id = url.match(/(\d+)\.flv/)[1]
  end

  def provider
    :sibnet
  end

  def download!
    metadata_url = "http://video.sibnet.ru/shell_config_xml.php?videoid=#{@video_id}&type=video.sibnet.ru"
    metadata = Nokogiri::XML(open metadata_url)
    file_url = metadata.at_xpath('//file').text()
    extension = file_url.match(/\.(\w+)$/)[1]

    `wget -q -O "/home/eskat0n/#{@anime_title} - #{@number} (#{@name}).#{extension}" "#{file_url}"`
  end
end