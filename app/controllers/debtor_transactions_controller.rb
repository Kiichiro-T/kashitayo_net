class DebtorTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
    def new
      @transaction = DebtorTransaction.new
    end
  
    def create
      @transaction = DebtorTransaction.new(transaction_params)
      if @transaction.save
        flash[:success] = "作成成功！"
        redirect_to root_url
      else
        render 'debtor_new'
      end
    end

    def transaction_params
      params.require(:debtor_transaction).permit(:debtor_id, :creditor_id, :debt, :repayment)
    end
end
