class AddUsernamesToMessages < ActiveRecord::Migration
  def change
    add_column :chatmessages, :username, :text
  end
end
