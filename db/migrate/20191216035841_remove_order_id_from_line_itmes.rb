class RemoveOrderIdFromLineItmes < ActiveRecord::Migration[5.2]
  def change
  	remove_column :line_items, :order_id
  end
end
