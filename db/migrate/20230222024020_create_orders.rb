class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :order_total
      t.decimal :discount

      t.timestamps
    end
  end
end
