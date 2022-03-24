class CreateSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.string :file_name
      t.string :end_time
      t.string :start_time
      t.string :text
      t.string :file_filter
    end
  end
end
