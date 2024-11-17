class CreateCustomFieldConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_field_configurations do |t|
      t.references :client, null: false, foreign_key: true
      t.string :field_name, null: false
      t.integer :field_type, null: false, comment: "0: number, 1: freeform, 2: enum"

      t.timestamps
    end
  end
end
