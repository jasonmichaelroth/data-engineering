require 'csv'

class Importer
  include ActiveModel::Validations

  attr_reader :gross_revenue
  attr_accessor :tab_file
  validates :tab_file, presence: {message: 'is required'}
  validate :verify_tab_file, unless: 'tab_file.blank?'

  def import(file)
    @tab_file = file
    return false unless valid?

    Rails.logger.info "Importing #{@tab_file}"

    file = File.read(@tab_file)
    csv = CSV.parse(file, {col_sep: "\t", headers: true})

    ActiveRecord::Base.transaction do
      @gross_revenue = 0

      csv.each_with_index do |row,index|
        # account for the header, and the zero index
        @csv_line = index+2

        purchaser = Purchaser.find_or_create_by_name(name: row[0])

        merchant = Merchant.find_or_create_by_name_and_address(
          address: row[4],
          name: row[5]
        )

        item = merchant.items.find_or_create_by_description_and_price(
          description: row[1],
          price: row[2]
        )

        purchase = Purchase.create(
          num_items: row[3],
          purchaser: purchaser,
          item: item
        )

        # Trigger a rollback if any of the models are invalid.
        # This invalidates the entire imported file, which is intended. This can
        # be refactored to serve as a filter for valid rows, but then it should
        # be abstracted to it's own model for better control and reporting.
        purchaser.save! and merchant.save! and item.save! and purchase.save!

        @gross_revenue += purchase.num_items * item.price

      end
    end

    true

  rescue ActiveRecord::RecordInvalid
    errors.add(:tab_file, "has an invalid row at line #{@csv_line}")
    @gross_revenue = nil
    false

  rescue ArgumentError, CSV::MalformedCSVError, Errno::ENOENT
    errors.add(:tab_file, 'is not a tab deliminated file')
    false
  end


  private

  def verify_tab_file
    unless File.exists?(tab_file)
      errors.add(:tab_file, 'does not exist')
    end
  end

end