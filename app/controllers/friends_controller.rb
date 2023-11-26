class FriendsController < ApplicationController
  def create
    new_friend = Friend.new(user: current_user,friend_id: params[:friend_id])
    if new_friend.save
      redirect_to root_path, notice: 'Friend added successfully'
    else
      redirect_to root_path, notice: 'Friend not added'
    end
  end
end