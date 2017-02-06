class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :url, null: false
      t.string :state, null: false, default: 'pending'

      t.timestamps
    end

    add_index :requests, :url
  end
end
