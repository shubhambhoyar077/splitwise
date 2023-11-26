class ExpenseSplit < ApplicationRecord
  belongs_to :recipient
  belongs_to :expense
end
