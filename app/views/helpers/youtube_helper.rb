class YoutubeHelper
  # Shamelessly lifted from `auto_html` gem
  def self.embed(url, width = 960)
    youtube_id = YoutubeHelper.video_id(url)
    src = "//www.youtube.com/embed/#{youtube_id}"
    src += "?wmode=opaque"
    src += "&theme=dark"
    src += "&rel=0"
    src += "&showinfo=1"
    src += "&modestbranding=1"
    src += "&controls=2"
    src += "&autohide=1"
    src += "&iv_load_policy=3"
    src += "&enablejsapi=1"
    src += "&hd=1"
    src += "&vq=hd1080"
    %{<iframe id="ytplayer-#{youtube_id}" width="#{width}" height="#{width *  9/16}" src="#{src}" frameborder="0" allowfullscreen></iframe>}
  end

  def self.small_embed(url)
    YoutubeHelper.embed(url, 148)
  end

  def self.featured(url)
    youtube_id = YoutubeHelper.video_id(url)
    %{<img width="300" height="170" src="http://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg" />}
  end

  def self.thumb(url)
    youtube_id = YoutubeHelper.video_id(url)
    %{<img width="148" height="84" src="http://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg" />}
  end

  def self.video_id(url)
    regex = /https?:\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/
    url.gsub(regex) do
      return $3
    end
  end
end