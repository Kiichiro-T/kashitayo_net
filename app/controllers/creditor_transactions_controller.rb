class CreditorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @transactions = CreditorTransaction.where(debtor_id: current_user.id)
  end

  def new
    @transaction = CreditorTransaction.new
  end
  
  def create
    @transaction = CreditorTransaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "作成成功！"
      redirect_to creditor_transactions_url
    else
      render 'new'
    end
  end

  def edit
    @transaction = CreditorTransaction.find(params[:id])
  end

  def update
    @transaction = CreditorTransaction.find(params[:id])
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "編集に成功しました"
      redirect_to creditor_transactions_url
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = CreditorTransaction.find(params[:id])
    @transaction.destroy
    flash[:success] = "削除しました"
    redirect_to creditor_transactions_url
  end

  private
    def transaction_params
      params.require(:creditor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end
end
