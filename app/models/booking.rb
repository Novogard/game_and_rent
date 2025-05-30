class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ['Pending', 'Accepted', 'Rejected'] }
end
