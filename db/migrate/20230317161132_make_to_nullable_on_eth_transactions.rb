class MakeToNullableOnEthTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :eth_transactions, :to, true
  end
end
