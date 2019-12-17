class CreditorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :different_user_or_already_approve_deny_redirect_root, only: [:approval, :approve_or_deny]
  
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
    @debtor = User.find(@transaction.debtor_id)
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

    def different_user_or_already_approve_deny_redirect_root
      @transaction = CreditorTransaction.find(params[:id])
        if @transaction.creditor_id != current_user.id
          redirect_to root_url
        elsif @transaction.approval == true
          redirect_to root_url
        elsif @transaction.approval == false
          redirect_to root_url
        end
    end
end
