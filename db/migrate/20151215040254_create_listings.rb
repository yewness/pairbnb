class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :home_type
      t.string :room_type
      t.string :city
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
