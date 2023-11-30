require 'rails_helper'

describe User, type: :model do
  # subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.') }

  # before { subject.save }
  it 'Valid user' do
    user = Fabricate(:user)
    expect(user).to be_valid
  end

  it 'Name should be present' do
    user = Fabricate.build(:user, name: '')
    expect(user).to_not be_valid
  end

  it 'Getting all friends for user' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    Fabricate(:friend, user: user1, friend_id: user2.id)
    result = user1.all_friends

    expect(result).to include(user2)
    expect(result.count).to eq(1)
  end

  it 'Getting all non friend list' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    user3 = Fabricate(:user)
    result = user1.not_friends

    expect(result).to include(user2, user3)
    expect(result.count).to eq(2)
  end

  it 'Getting balance details, you_owe and you_are_owed list' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    Fabricate(:friend, user: user1, friend_id: user2.id)
    expense = Fabricate(:expense, payer: user1)
    es1 = Fabricate(:expense_split, recipient: user1, expense: expense, amount: expense.total_amount/2)
    es2 = Fabricate(:expense_split, recipient: user2, expense: expense, amount: expense.total_amount/2)
    user1_result = user1.balance_detail
    user2_result = user2.balance_detail

    expect(user1_result[:balance]).to eq(es1.amount)
    expect(user1_result[:total_you_owe]).to eq(0)
    expect(user1_result[:total_you_are_owed]).to eq(es2.amount)
    expect(user1_result[:you_are_owed][0][:recipient]).to eq(user2)
    expect(user1_result[:you_are_owed][0][:amount]).to eq(es2.amount)

    expect(user2_result[:balance]).to eq(-es2.amount)
    expect(user2_result[:total_you_owe]).to eq(es2.amount)
    expect(user2_result[:total_you_are_owed]).to eq(0)
    expect(user2_result[:you_owe][0][:payer]).to eq(user1)
    expect(user2_result[:you_owe][0][:amount]).to eq(es2.amount)
  end
end