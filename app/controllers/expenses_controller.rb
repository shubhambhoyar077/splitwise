class ExpensesController < ApplicationController

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to root_path, notice: 'Expense added successfully'
    else
      redirect_to root_path, alert: 'Expense not added'
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:date, :description, :total_amount, :payer_id, expense_splits_attributes: [:id, :recipient_id, :amount, :_destroy])
  end
end