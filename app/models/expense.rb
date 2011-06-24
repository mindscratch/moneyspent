class Expense
  include Mongoid::Document
  field :amount, :type => Float
  field :merchant, :type => String
  field :payment_method, :type => String

  validates_presence_of :amount, :merchant, :payment_method

  embedded_in :user

  def self.total(expenses)
    result = 0
    unless expenses.blank?
      expenses.inject do |sum, expense|
        sum + expense.amount
      end
    end
    result
  end
end
