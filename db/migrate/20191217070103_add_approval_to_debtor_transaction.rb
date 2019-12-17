class AddApprovalToDebtorTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :debtor_transactions, :approval, :boolean
  end
end
