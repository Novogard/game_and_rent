class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :bookings, dependent: :destroy
  validates :description, presence: true, length: { minimum: 10 }
  validates :rate_per_day, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, presence: true
end
