class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ""
      t.string :student_id, null: false, default: "",unique: true
      t.string :line_id, null: false, default: "",unique: true
      t.string :token, null: false, default: "",unique: true

      t.timestamps
    end
  end
end
