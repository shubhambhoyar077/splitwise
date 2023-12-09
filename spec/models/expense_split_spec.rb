require 'rails_helper'

describe ExpenseSplit, type: :model do

  it 'Valid expense_split' do
    user = Fabricate(:user)
    expense = Fabricate(:expense, payer: user)
    es = Fabricate.build(:expense_split, expense: expense, recipient: user)
    expect(es).to be_valid
  end

  it 'Required valid expense in expense' do
    user = Fabricate(:user)
    es = Fabricate.build(:expense_split, expense: nil, recipient: user)
    expect(es).to_not be_valid
  end

  it 'Required valid recipient in expense' do
    user = Fabricate(:user)
    expense = Fabricate(:expense, payer: user)
    es = Fabricate.build(:expense_split, expense: expense, recipient: nil)
    expect(es).to_not be_valid
  end

  it 'Required valid amount in expense' do
    user = Fabricate(:user)
    expense = Fabricate.build(:expense, payer: user, description: nil)
    es = Fabricate.build(:expense_split, expense: expense, recipient: user, amount: nil)
    expect(es).to_not be_valid
  end

end