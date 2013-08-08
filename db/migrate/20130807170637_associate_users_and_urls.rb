class AssociateUsersAndUrls < ActiveRecord::Migration
  def change
    change_table :urls do |t|
      t.belongs_to :user, index: true
    end
  end
end
