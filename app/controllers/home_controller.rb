class HomeController < ApplicationController
  def index
    @eth_block = EthBlock.last
  end
end
