class PaymentMethodsController < ApplicationController
	def new
		reservation = Reservation.find(params[:reservation_id])
		listing = Listing.find(reservation.listing_id)
		@total_price = (reservation.end_date - reservation.start_date) * listing.price.to_i
	end

	def create
		reservation = Reservation.find(params[:reservation_id])
		listing = Listing.find(reservation.listing_id)
		total_price = (reservation.end_date - reservation.start_date).to_i * (listing.price.to_i)

		if current_user.braintree_id?
			customer = Braintree::Customer.find(current_user.braintree_id)
		else
			result = Braintree::Customer.create(
				email: current_user.email,
				payment_method_nonce: params[:payment_method_nonce]
				)
			customer = result.customer
			current_user.update(braintree_id: customer.id)
		end

		result = Braintree::Transaction.sale(
			  amount: total_price.to_s,
  			  payment_method_nonce: params[:payment_method_nonce],
  			  merchant_account_id: "mybnb",
  			  options: {
    		  submit_for_settlement: true
    			}
			)
		reservation.update(braintree_transaction_id: result.transaction.id)
		redirect_to listing_reservation_path(listing, reservation), notice: "Fuck you! #{total_price.to_s} is in my pocket now"
	end
end