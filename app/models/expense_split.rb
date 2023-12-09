class ExpenseSplit < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :expense

  validates :recipient_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
