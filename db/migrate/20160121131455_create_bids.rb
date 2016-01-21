class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal  :value,  default: 0.0, null: false

      t.timestamps null: false
    end
    add_reference :bids, :user, index: true
    add_reference :bids, :auction, index: true
  end
end
