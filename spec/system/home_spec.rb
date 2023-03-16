require "rails_helper"

RSpec.describe "visiting home page" do
  it "shows the latest eth block along with its transactions" do
    EthBlock.create!(number: "abc123")

    visit root_path

    expect(page).to have_text("abc123")
  end
end
