class EthPrice < ApplicationRecord
  validates :usd_value, presence: true

  def self.fetch_latest
    last_made = EthPrice.last
    return last_made if last_made && last_made.created_recently?

    latest_price = CoinMarketCap.eth.latest_price
    EthPrice.create!(usd_value: latest_price)
  end

  def self.convert_to_usd(eth_amount)
    fetch_latest.convert_to_usd(eth_amount)
  end

  def created_recently?
    self.created_at > 10.minutes.ago
  end

  def convert_to_usd(eth_amount)
    usd_value * eth_amount
  end
end
