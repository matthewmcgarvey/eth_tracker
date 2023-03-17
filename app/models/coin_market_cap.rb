module CoinMarketCap
  def self.eth
    client = CoinMarketCap::Client.new
    CoinMarketCap::Eth.new(client)
  end
end
