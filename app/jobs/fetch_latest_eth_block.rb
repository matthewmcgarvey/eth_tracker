class FetchLatestEthBlock
  include Sidekiq::Job

  def perform
    json = Alchemy.eth.block_number
    block_number = json['result']
    FindOrLoadEthBlock.new.perform(block_number)
  end
end
