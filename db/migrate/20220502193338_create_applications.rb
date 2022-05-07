class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :token, index: true, unique: true
      t.string :name
      t.integer :chat_count

      t.timestamps
    end
  end
end
