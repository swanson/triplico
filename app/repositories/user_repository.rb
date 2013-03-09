require_relative "../models/user"

class UserRepository
  def self.authenticate(username, password)
    user = User.where(username: username).first
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def self.all_usernames
    User.all.map{|u| u.username}
  end

  def self.find_by_username(username)
    User.where(username: username).first
  end
end