class PriceRecord < ApplicationRecord
  belongs_to :product

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :store_name, presence: true
  validates :recorded_at, presence: true

  before_validation :set_recorded_at

  private

  def set_recorded_at
    self.recorded_at ||= Time.current
  end
end