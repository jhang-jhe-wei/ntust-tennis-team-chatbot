class CreateRests < ActiveRecord::Migration[6.1]
  def change
    create_table :rests do |t|
      t.date :rest_date
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
