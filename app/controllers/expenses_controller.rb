class ExpensesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @total_expenses = Expense.total(current_user.expenses)
    @expense = Expense.new
  end


end
