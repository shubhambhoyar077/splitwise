class Expense < ApplicationRecord
  belongs_to :payer, class_name: "User"
  has_many :expense_splits

  validates :payer_id, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :date, presence: true
end
