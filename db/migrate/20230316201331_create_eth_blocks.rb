class CreateEthBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :eth_blocks do |t|
      t.string :number, null: false

      t.timestamps
    end
  end
end
