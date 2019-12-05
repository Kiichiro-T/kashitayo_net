class TransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "作成成功！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end
end
