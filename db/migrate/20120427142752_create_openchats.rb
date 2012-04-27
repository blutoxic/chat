class CreateOpenchats < ActiveRecord::Migration
  def change
    create_table :openchats do |t|
      t.integer :creator_id
      t.integer :chat_partner_id
      t.timestamps
    end
  end
end
