class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.string :password
      u.string :email
    end
  end
end
