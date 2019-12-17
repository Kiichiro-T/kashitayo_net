class DebtorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]
  before_action :different_user_or_already_approve_deny_redirect_root, only: [:approval, :approve_or_deny]

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
      redirect_to debtor_transactions_url
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
      redirect_to debtor_transactions_url
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = DebtorTransaction.find(params[:id])
    @transaction.destroy
    flash[:success] = "削除しました"
    redirect_to debtor_transactions_url
  end

  def approval
    @creditor = User.find(@transaction.creditor_id)
  end

  def approve_or_deny  
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
      params.require(:debtor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end

    def approve_or_deny_transaction_params
      params.require(:debtor_transaction).permit(:approval)
    end

    def different_user_or_already_approve_deny_redirect_root
      @transaction = DebtorTransaction.find(params[:id])
        if @transaction.debtor_id != current_user.id
          redirect_to root_url
        elsif @transaction.approval == true
          redirect_to root_url
        elsif @transaction.approval == false
          redirect_to root_url
        end
    end
end
