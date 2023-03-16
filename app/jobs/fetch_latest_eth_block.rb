class FetchLatestEthBlock < ApplicationJob
  def perform
    block_number = fetch_latest_block_number
    return if block_already_stored?(block_number)

    load_block_data(block_number)
  end

  private

  def fetch_latest_block_number
    json = Alchemy.eth.block_number
    json['result']
  end

  def block_already_stored?(block_number)
    EthBlock.where(number: block_number).any?
  end

  def load_block_data(block_number)
    eth_block = EthBlock.new(number: block_number)
    block_json = Alchemy.eth.get_block_by_number(block_number)
    block_json.dig("result", "transactions").each do |transaction|
      eth_block.eth_transactions.build(
        from: transaction["from"],
        to: transaction["to"],
        value: convert_to_ether(transaction["value"])
      )
    end

    eth_block.save!
  end

  def convert_to_ether(wei)
    Float(wei) * (10 ** -18)
  end
end
