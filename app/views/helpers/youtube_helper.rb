class YoutubeHelper
  # Shamelessly lifted from `auto_html` gem
  def self.embed(url, width = 304)
    youtube_id = YoutubeHelper.extract_id(url)
    src = "//www.youtube.com/embed/#{youtube_id}"
    src += "?wmode=opaque"
    src += "&theme=dark"
    src += "&HD=1"
    src += "&rel=0"
    src += "&showinfo=0"
    %{<iframe width="#{width}" height="#{width *  9/16}" src="#{src}" frameborder="0" allowfullscreen></iframe>}
  end

  def self.small_embed(url)
    YoutubeHelper.embed(url, 150)
  end

  def self.featured(url)
    youtube_id = YoutubeHelper.extract_id(url)
    %{<a href="#{url}" target="_blank"><img width="300" height="170" src="http://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg" /></a>}
  end

  def self.thumb(url)
    youtube_id = YoutubeHelper.extract_id(url)
    %{<a href="#{url}" target="_blank"><img width="148" height="84" src="http://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg" /></a>}
  end

  private
  def self.extract_id(url)
    regex = /https?:\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/
    url.gsub(regex) do
      return $3
    end
  end
end