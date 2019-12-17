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

  def approval
    @transaction = CreditorTransaction.find(params[:id])
    unless @transaction.creditor_id == current_user.id
      redirect_to root_url
    end
  end

  def approve_or_deny
    @transaction = CreditorTransaction.find(params[:id])
    if @transaction.update_attributes(approve_or_deny_transaction_params)
      if @transaction.approval == true
        flash[:success] = "承認しました"
        redirect_to root_url
      else @transaction.approval == false
        flash[:success] = "拒否しました"
        redirect_to root_url
      end
    else
      render 'approval'
    end
  end

  private
    def transaction_params
      params.require(:creditor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end

    def approve_or_deny_transaction_params
      params.require(:creditor_transaction).permit(:approval)
    end
end
