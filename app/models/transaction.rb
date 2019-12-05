class Transaction < ApplicationRecord
  belongs_to :debtor
  belongs_to :creditor
  validates :debt, presence: true
  validates :debt, numericality: { only_integer: true}
  validates :debt, numericality: { greater_than_or_equal_to: 0 } 
end
