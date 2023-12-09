class StaticController < ApplicationController
  def dashboard
    @friends = current_user.all_friends
    @not_friends = current_user.not_friends
    @expense = Expense.new
    @expense.expense_splits.new
  end

  def person
    @user = User.find(params[:id])
    @friends = current_user.all_friends
    @not_friends = current_user.not_friends
    @expense_splits = @user.expense_splits
    unless @user.in?([current_user]+@friends)
      redirect_to root_path
    end
  end
end
