class Expense
  include Mongoid::Document
  field :merchant, :type => String
  field :amount, :type => Float
  field :payment_method, :type => String
  embedded_in :user
  validates_presence_of :amount, :merchant, :payment_method

  GROUP_BY_FIELDS = [:merchant, :payment_method].freeze
  PAYMENT_METHODS = ['cash', 'credit', 'debit', 'check'].freeze

  def self.payment_methods
    PAYMENT_METHODS
  end

  def self.group_by(field, expenses)
    # outta check out how mongoid supports grouping instead of doing it here
    raise "Unable to perform group_by operation, field was not specified" if field.blank?
    raise "Unable to perform group_by operation, invalid field '#{field}'" unless GROUP_BY_FIELDS.include? field.intern

    field = field.to_s unless field.is_a?(String)

    results = {}
    unless expenses.blank?
      expenses.each do |expense|
        key = expense[field]
        if results.has_key? key
          results[key] += expense.amount
        else
          results[key] = expense.amount
        end

      end
    end
    results
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
