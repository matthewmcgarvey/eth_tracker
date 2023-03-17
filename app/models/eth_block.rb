class EthBlock < ApplicationRecord
  has_many :eth_transactions

  validates :number, presence: true
end
