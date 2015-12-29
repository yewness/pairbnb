class ReservationMailer < ApplicationMailer
	default from: "yewrails@gmail.com"
  	layout 'mailer'

	def confirmation_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		mail(to: customer.user.email, subject: "Your room is reserved!")
	end
end
