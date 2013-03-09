require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/flash"

require_relative "app/models/user"

class Triplica < Sinatra::Base
  configure do
    set :database_file, "config/database.yml"
    set :views, "app/views"
    set :public_folder, "app/public"

    enable :sessions
    set :session_secret, "secret!"

    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
  end

  helpers do
    # allow for partials using this syntax
    # = render partial: :foo
    def render(*args)
      if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
        locals = args.first[:locals] || {}
        return haml "partials/_#{args.first[:partial]}".to_sym, layout: false, locals: locals
      else
        super
      end
    end

    def current_user
      @current_user ||= User.find(:first, 
                                  include: :videos, 
                                  conditions: ["id = ?", session[:user_id]]
                                 ) if session[:user_id]
    end
  end

  get "/" do 
    if current_user
      redirect to("/feed")
    else
      redirect to("/login")
    end
  end
end

require_relative "app/controllers/sessions_controller"
require_relative "app/controllers/users_controller"
require_relative "app/controllers/videos_controller"
require_relative "app/controllers/feeds_controller"
require_relative "app/controllers/buddies_controller"
require_relative "app/views/helpers/youtube_helper"