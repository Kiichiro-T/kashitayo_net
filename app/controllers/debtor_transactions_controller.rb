class DebtorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]

  def index
    @transactions = DebtorTransaction.where(creditor_id: current_user.id)
  end
  
  def new
    @transaction = DebtorTransaction.new
  end
  
  def create
    @transaction = DebtorTransaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "作成成功！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @transaction = DebtorTransaction.find(params[:id])
  end

  def update
    @transaction = DebtorTransaction.find(params[:id])
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "編集に成功しました"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    def transaction_params
      params.require(:debtor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end
end
