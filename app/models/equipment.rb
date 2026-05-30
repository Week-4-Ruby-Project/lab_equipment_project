class Equipment < ApplicationRecord
  belongs_to :category 
  has_many :maintenance_records, dependent: :destroy

  ALLOWED_STATUSES =%w[available in_use maintenance].freeze
  
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES }
  validates :serial_number, presence: true, uniqueness: true
  validates :category_id, presence: true

  validate :serial_number_format_must_be_valid
  validate : name_must_be_real

  private

  def serial_number_format_must_be_valid
    return if serial_number.blank?

    unless serial_number.match?(/\A[A-Z]{3}-\d{3}\z/)
      errors.add(:serial_number, "must match format XXX-NNN (three uppercase letters, a dash , three digits)")
    end

  end

  def name_must_be_real
    return if name.blank?

    unless name.match?(/[A-Za-z]/)
      errors.add(:name, "must contain at least one letter")
    end
  end
end
