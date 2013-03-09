require_relative "../models/user"

class Triplica < Sinatra::Base
  get "/signup" do
    @user = User.new

    haml :"users/new"
  end

  post "/signup" do
    if params[:secret] == "bacon"
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Signed up!"
        redirect to("/")
      else
        flash[:error] = "Something went wrong :("
        haml :"users/new"
      end
    else
      flash[:error] = "Something went wrong :("
      haml :"users/new"
    end
  end
end