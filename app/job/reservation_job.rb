class ReservationJob < ActiveJob::Base

	def perform(customer, host, reservation_id)
		ReservationMailer.confirmation_email(customer, host, reservation_id).deliver_now
	end
end