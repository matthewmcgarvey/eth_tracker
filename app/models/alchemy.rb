module Alchemy
  def self.eth
    client = Alchemy::Client.new
    Alchemy::Eth.new(client)
  end
end
