require_relative "../models/user"
require_relative "../repositories/user_repository"

class Triplica < Sinatra::Base
  get "/login" do
    haml :"sessions/new"
  end

  post "/login" do
    user = UserRepository.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in!"
      redirect to("/")
    else
      flash.now[:error] = "Invalid username or password"
      haml :"sessions/new"
    end
  end

  get "/logout" do
    session[:user_id] = nil
    redirect to("/")
  end
end