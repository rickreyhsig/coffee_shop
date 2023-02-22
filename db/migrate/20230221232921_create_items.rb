class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :description
      t.decimal :price, :precision => 9, :scale => 2
      t.decimal :tax_rate
      t.integer :quantity

      t.timestamps
    end
  end
end
