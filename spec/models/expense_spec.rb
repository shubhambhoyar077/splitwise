require 'rails_helper'

describe Expense, type: :model do

  it 'Valid expense' do
    user = Fabricate(:user)
    expense = Fabricate.build(:expense, payer: user)
    expect(expense).to be_valid
  end

  it 'Required valid payer in expense' do
    expense = Fabricate.build(:expense, payer: nil)
    expect(expense).to_not be_valid
  end

  it 'Required total_amount in expense' do
    user = Fabricate(:user)
    expense = Fabricate.build(:expense, payer: user, total_amount: nil)
    expect(expense).to_not be_valid
  end

  it 'Required valid payer in expense' do
    user = Fabricate(:user)
    expense = Fabricate.build(:expense, payer: user, description: nil)
    expect(expense).to_not be_valid
  end

  it 'Required valid payer in expense' do
    user = Fabricate(:user)
    expense = Fabricate.build(:expense, payer: user, date: nil)
    expect(expense).to_not be_valid
  end

end