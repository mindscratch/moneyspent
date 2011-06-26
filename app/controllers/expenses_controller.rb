class ExpensesController < ApplicationController

  before_filter :authenticate_user!

  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = current_user.expenses
    @total_amount = Expense.total(current_user.expenses)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = current_user.expenses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = current_user.expenses.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    current_user.expenses.build(params[:expense])

    respond_to do |format|
      if current_user.save
        format.html { redirect_to(expenses_url, :notice => 'Expense was successfully created.') }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = current_user.expenses.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(expenses_url, :notice => 'Expense was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = current_user.expenses.where("_id" => params[:id]).delete_all

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      format.xml  { head :ok }
    end
  end

  def group_by
    response = {}
    success = false
    begin
      response = Expense.group_by params[:field], current_user.expenses
      success = true
    rescue Exception => ex
      response = "Error occurred while grouping expenses: #{ex.message}"
    end

    respond_to do |format|
      format.json {
        render :json => response, :status => (success ? 200 : 500)
      }
    end
  end
end
