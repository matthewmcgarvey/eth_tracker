require "rails_helper"

RSpec.describe "visiting home page" do
  it "shows the latest eth block along with its transactions" do
    EthPrice.create!(usd_value: 1000.0)
    EthBlock.create!(number: "0x0")

    visit root_path

    expect(page).to have_text("0x0 (0)")
  end
end
