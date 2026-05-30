class CreateMaintenanceRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :maintenance_records do |t|
      t.text :description
      t.datetime :performed_at
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
