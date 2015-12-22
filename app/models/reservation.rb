class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  validates :start_date, :end_date, overlap: true
end
