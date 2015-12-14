class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.decimal :bid
      t.integer :duration
      t.timestamps null: false
    end
  end
end
