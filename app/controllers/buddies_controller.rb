require_relative "../repositories/user_repository"

class Triplica < Sinatra::Base
  get "/buddies/new" do
    @potential_buddies = get_potential_buddies
    haml :"/buddies/new"
  end

  post "/buddies/new" do
    buddy = UserRepository.find_by_username(params[:buddy])
    if current_user.buddy_one.nil?
      current_user.buddy_one = buddy
      flash[:succes] = "Added #{buddy} as your buddy."
      halt redirect to("/feed")
    elsif current_user.buddy_two.nil?
      current_user.buddy_two = buddy
      flash[:succes] = "Added #{buddy} as your buddy."
      halt redirect to("/feed")
    else
      flash[:error] = "Something went wrong :("
      @potential_buddies = get_potential_buddies
      haml :"/buddies/new"
    end
  end

  def get_potential_buddies
    all_users = UserRepository.all_usernames
    all_users.delete(current_user.username)
    all_users
  end
end