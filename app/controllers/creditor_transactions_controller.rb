class CreditorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  
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
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
    def transaction_params
      params.require(:creditor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end
end
