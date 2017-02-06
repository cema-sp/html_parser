class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :request, foreign_key: true, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
