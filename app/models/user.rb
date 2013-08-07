require 'bcrypt'

class User < ActiveRecord::Base

  def self.authenticate(email, password)
    user = User.where("email = ?", email).first || User
    unless user.nil?
      if BCrypt::Password.new(user.password) == password 
        return user
      else
        return nil  
      end
    end
  end
end


