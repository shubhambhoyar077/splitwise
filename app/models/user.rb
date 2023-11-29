class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :friends, foreign_key: 'friend_id'
 has_many :expenses, foreign_key: 'payer_id'
 has_many :expense_splits, foreign_key: 'recipient_id'

 def all_friends
  friend_i_added = Friend.where(user_id: id).pluck(:friend_id)
  friend_they_added_me = Friend.where(friend_id: id).pluck(:user_id)
  ids = friend_i_added + friend_they_added_me
  User.where(id: ids)
end

def not_friends
  User.where.not(id: id) - all_friends
end

def balance_detail
  balance_detail = {}
  you_owe_list = you_owe
  you_are_owed_list = you_are_owed
  temp_you_owe_list = you_owe_list.dup

  temp_you_owe_list.each do |payer|
    recipient = you_are_owed_list.find { |hash| hash[:recipient].id == payer[:payer].id }
    puts "---------"
    puts payer
    puts recipient
    puts "---------"
    if recipient
      if payer[:amount] < recipient[:amount]
        recipient[:amount] -= payer[:amount]
        you_owe_list.delete_if { |hash| hash[:payer].id == payer[:payer].id }
      elsif payer[:amount] > recipient[:amount]
        payer[:amount] -= recipient[:amount]
        you_are_owed_list.delete_if { |hash| hash[:recipient].id == recipient[:recipient].id }
      else
        you_owe_list.delete_if { |hash| hash[:payer].id == payer[:payer].id }
        you_are_owed_list.delete_if { |hash| hash[:recipient].id == recipient[:recipient].id }
      end
    end
  end

  total_you_owe = you_owe_list.sum { |hash| hash[:amount] }
  total_you_are_owed = you_are_owed_list.sum { |hash| hash[:amount] }

  balance_detail[:you_owe] = you_owe_list
  balance_detail[:you_are_owed] = you_are_owed_list 
  balance_detail[:total_you_owe] = total_you_owe
  balance_detail[:total_you_are_owed] = total_you_are_owed
  balance_detail[:balance] = total_you_are_owed - total_you_owe

  balance_detail
end


def you_owe
  you_owe_list = []
  temp_you_owe_list = ExpenseSplit.where(recipient_id: id).where.not(expense: expenses)
  temp_you_owe_list.each do |you_owe|
    payer = you_owe_list.find { |hash| hash[:payer].id == you_owe.expense.payer_id }
    if payer
      payer[:amount] = payer[:amount]+you_owe.amount
    else
      you_owe_list << {payer:you_owe.expense.payer, amount: you_owe.amount}
    end
  end
  you_owe_list
end

def you_are_owed
  you_are_owed_list = []
  temp_you_are_owed_list = ExpenseSplit.where(expense: expenses).where.not(recipient_id: id)
  temp_you_are_owed_list.each do |you_are_owed|
    recipient = you_are_owed_list.find { |hash| hash[:recipient].id == you_are_owed.recipient_id }
    if recipient
      recipient[:amount] = recipient[:amount]+you_are_owed.amount
    else
      you_are_owed_list << {recipient:you_are_owed.recipient, amount: you_are_owed.amount}
    end
  end
  you_are_owed_list
end
end
