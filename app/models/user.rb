class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :friends, foreign_key: 'friend_id'

 def all_friends
  friend_i_added = Friend.where(user_id: id).pluck(:friend_id)
  friend_they_added_me = Friend.where(friend_id: id).pluck(:user_id)
  ids = friend_i_added + friend_they_added_me
  User.where(id: ids)
end

def not_friends
  User.where.not(id: id) - all_friends
end
end
