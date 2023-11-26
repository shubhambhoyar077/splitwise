class StaticController < ApplicationController
  def dashboard
    @friends = current_user.all_friends
    @not_friends = current_user.not_friends
    @expense = Expense.new
    @expense.expense_splits.new
  end

  def person
  end
end
