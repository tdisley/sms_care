# This class is for the automatic creaton of the table in the database
class CreateMessageModel < ActiveRecord::Migration
  # TODO: Maybe refactor the types
  def change
    create_table :messages do |t|
      t.column :secret, :string
      t.column :from, :string
      t.column :message, :string
      t.column :sent_timestamp, :string
      t.column :sent_to, :string
      t.column :message_id, :string
      t.column :device_id, :string
    end
  end
end
