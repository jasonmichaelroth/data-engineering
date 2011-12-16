class Item < ActiveRecord::Base

  validates :description, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}

  belongs_to :merchant

  delegate :address, :name, to: :merchant, prefix: true

end