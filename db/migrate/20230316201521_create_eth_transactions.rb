class CreateEthTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :eth_transactions do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.decimal :value, null: false
      t.references :eth_block

      t.timestamps
    end
  end
end
