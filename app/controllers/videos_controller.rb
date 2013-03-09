require_relative "../models/video"

class Triplica < Sinatra::Base
  get "/videos/new" do
    @video = Video.new
    haml :"videos/new"
  end

  post "/videos/new" do
    @video = Video.new(url: params[:url], user: current_user)

    if @video.save
      flash[:notice] = "Video posted."
      redirect to("/")
    else
      flash[:error] = "Something went wrong :("
      haml :"videos/new"
    end
  end
end