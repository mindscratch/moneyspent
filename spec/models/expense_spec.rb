require 'spec_helper'

describe Expense do

  let(:expenses) {
     [Expense.new(merchant: 'shell', amount: 5.00, payment_method: 'cash'),
                  Expense.new(merchant: 'wal-mart', amount: 5.00, payment_method: 'credit'),
                  Expense.new(merchant: 'wal-mart', amount: 7.00, payment_method: 'debit'),
                  Expense.new(merchant: 'shell', amount: 15.00, payment_method: 'credit'),
                  Expense.new(merchant: 'shell', amount: 17.00, payment_method: 'cash')]
  }

  context "#total" do
    it "should equal 49 when the expenses have amounts of 5,5,7,15 and 17" do
      result = Expense.total expenses
      result.should == 49
    end
  end

  context "#group_by" do
    it "should return a hash like {'wal-mart': 12.00, 'shell': 37.00}" do
      result = Expense.group_by :merchant, expenses
      result.should_not be_nil
      result['wal-mart'].should == 12.00
      result['shell'].should == 37.00
    end

    it "should return a hash like {'cash': 22.00, 'credit': 20.00, 'debit': 7.00}" do
      result = Expense.group_by :payment_method, expenses
      result.should_not be_nil
      result['cash'].should == 22.00
      result['credit'].should == 20.00
      result['debit'].should == 7.00
    end
  end
end
