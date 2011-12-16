class Purchaser < ActiveRecord::Base

  validates :name, presence: true

end