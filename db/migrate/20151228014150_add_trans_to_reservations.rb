class AddTransToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :braintree_transaction_id, :string
  end
end
