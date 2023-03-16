require 'net/http'

class EthBlockUpdater
  WEI_TO_ETH = 10 ** -18

  def self.fetch_latest_block
    client = AlchemyClient.new
    response = client.request(method: "eth_blockNumber")
    json = JSON.parse(response.body)
    return if EthBlock.where(number: json['result']).any?

    eth_block = EthBlock.new(number: json['result'])
    fetch_transaction_data(eth_block)
    eth_block.save!
  end

  def self.fetch_transaction_data(eth_block)
    client = AlchemyClient.new
    response = client.request(method: "eth_getBlockByNumber", params: [eth_block.number, true])
    json = JSON.parse(response.body)
    json.dig("result", "transactions").each do |transaction|
      value = WEI_TO_ETH * Float(transaction['value'])
      eth_block.eth_transactions.build(
        from: transaction['from'],
        to: transaction['to'],
        value: value,
        eth_block_id: eth_block.id
      )
    end
  end
end
