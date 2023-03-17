require "rails_helper"

RSpec.describe EthPrice do
  describe ".fetch_latest" do
    it "returns last record if created recently" do
      eth_price = EthPrice.create!(usd_value: 2)

      expect(EthPrice.fetch_latest).to eq(eth_price)
    end

    it "pulls latest from CoinMarketCap if recent price not stored" do
      cmc_eth = instance_double(CoinMarketCap::Eth)
      allow(CoinMarketCap).to receive(:eth).and_return(cmc_eth)
      allow(cmc_eth).to receive(:latest_price).and_return(123)

      result = EthPrice.fetch_latest

      expect(result.usd_value).to eq(123)
    end
  end

  describe "#convert_to_usd" do
    it "multiplies given amount of ether by the usd value" do
      eth_price = EthPrice.new(usd_value: 2)

      result = eth_price.convert_to_usd(5)

      expect(result).to eq(10)
    end
  end

  describe "#created_recently?" do
    it "is true if created less than 10 minutes ago" do
      eth_price1 = EthPrice.new(created_at: Time.zone.now)
      eth_price2 = EthPrice.new(created_at: 8.minutes.ago)

      expect(eth_price1.created_recently?).to eq(true)
      expect(eth_price2.created_recently?).to eq(true)
    end

    it "is false if created more than 10 minutes ago" do
      eth_price = EthPrice.new(created_at: 11.minutes.ago)

      expect(eth_price.created_recently?).to eq(false)
    end
  end
end
