class Transaction < ApplicationRecord
    belongs_to :debtor, class_name: 'User', foreign_key: 'debtor_id'
    belongs_to :creditor, class_name: 'User', foreign_key: 'creditor_id'
    validates :debt, presence: true
    validates :debt, numericality: { only_integer: true}
    validates :debt, numericality: { greater_than_or_equal_to: 0 } 
  end
  