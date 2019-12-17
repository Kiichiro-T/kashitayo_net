class AddApprovalToCreditorTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :creditor_transactions, :approval, :boolean
  end
end
