class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string  :title
      t.text    :description
      t.integer :user_id
      t.decimal :starting_price
      t.integer :duration, null: false, default: '0'
      t.string  :picture

      t.timestamps null: false
    end
  end
end
