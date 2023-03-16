class EthBlock < ApplicationRecord
  has_many :eth_transactions
  after_commit { broadcast_replace_to 'eth_block', target: "eth_block" }

  validates :number, presence: true
end
