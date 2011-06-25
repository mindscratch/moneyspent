class Expense
  include Mongoid::Document
  field :merchant, :type => String
  field :amount, :type => Float
  field :payment_method, :type => String
  embedded_in :user
  validates_presence_of :amount, :merchant, :payment_method

  PAYMENT_METHODS = ['cash', 'credit', 'debit', 'check'].freeze

  def self.payment_methods
    PAYMENT_METHODS
  end

  def self.total(expenses)
    result = 0
    unless expenses.blank?
      result = expenses.inject(0) do |sum, expense|
        sum + expense.amount
      end
    end
    result
  end

end
