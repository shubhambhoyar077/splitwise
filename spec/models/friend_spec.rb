require 'rails_helper'

describe Friend, type: :model do

  it 'Required valid user_id in friend' do
    friend = Fabricate.build(:friend, user: nil, friend_id: 1)
    expect(friend).to_not be_valid
  end

end