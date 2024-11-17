class CreateCustomFieldValues < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_field_values do |t|
      t.references :building, null: false, foreign_key: true
      t.references :custom_field_configuration, null: false, foreign_key: true
      t.string :value, null: false

      t.timestamps
    end
  end
end
