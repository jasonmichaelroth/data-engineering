require 'csv'

class Purchase < ActiveRecord::Base

  belongs_to :purchaser, validate: true
  belongs_to :item, validate: true

  validates :num_items, presence: true, numericality: {greater_than: 0}
  validates :purchaser, presence: true
  validates :item, presence: true

  delegate :name, to: :purchaser, prefix: true
  delegate :description, :price, :merchant, to: :item, prefix: true

  # This could be done by delegating to a has_one :merchant, through: :item, but
  # I want to get the merchant's info from the item whether or not it's been
  # persisted.
  delegate :merchant_address, :merchant_name, to: :item, prefix: false

end