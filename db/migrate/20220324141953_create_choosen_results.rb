class CreateChoosenResults < ActiveRecord::Migration[7.0]
  def change
    create_table :choosen_results do |t|
      t.string :uniq_id
      t.string :text
      t.integer :hits

      t.timestamps
    end
  end
end
