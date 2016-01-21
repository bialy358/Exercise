class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text     :title
      t.text     :content
      t.integer  :receiver_id
      t.timestamps null: false
    end
    add_reference :messages, :user, index: true
  end
end
