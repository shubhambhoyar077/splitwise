class Friend < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: { scope: :friend_id }
  validates :friend_id, uniqueness: { scope: :user_id }
end
