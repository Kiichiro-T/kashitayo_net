class CreateDebtorTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :debtor_transactions do |t|
      t.references :debtor, foreign_key: { to_table: :users }
      t.integer :debt
      t.boolean :repayment, default: false, null: false

      t.timestamps
    end
  end
end
