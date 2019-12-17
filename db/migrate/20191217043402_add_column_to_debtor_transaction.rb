class AddColumnToDebtorTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :debtor_transactions, :creditor, foreign_key: { to_table: :users }
  end
end
