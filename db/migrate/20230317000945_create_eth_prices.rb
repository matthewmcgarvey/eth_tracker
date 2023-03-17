class CreateEthPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :eth_prices do |t|
      t.decimal :usd_value, null: false

      t.timestamps
    end
  end
end
