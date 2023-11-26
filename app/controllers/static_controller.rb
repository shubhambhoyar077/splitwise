class StaticController < ApplicationController
  def dashboard
    @friends = current_user.all_friends
    @not_friends = current_user.not_friends
  end

  def person
  end
end
