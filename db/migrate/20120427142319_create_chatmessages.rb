class CreateChatmessages < ActiveRecord::Migration
  def change
    create_table :chatmessages do |t|
      t.text    :content
      t.integer :creator_id
      t.integer :receiver_id
      t.timestamps
    end
  end
end
