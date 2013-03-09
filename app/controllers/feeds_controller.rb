class Triplica < Sinatra::Base
  get "/feed" do
    @left_user = current_user
    @middle_user = current_user.buddy_one
    @right_user = current_user.buddy_two

    haml :"feed/index"
  end
end