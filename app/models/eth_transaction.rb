class EthTransaction < ApplicationRecord
  belongs_to :eth_block

  validates :from, presence: true
  validates :value, presence: true
end
