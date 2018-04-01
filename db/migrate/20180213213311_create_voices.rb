class CreateVoices < ActiveRecord::Migration[5.0]
  def change
    create_table :voices do |t|
      t.integer :contest_id
      t.string :email
      t.string :name
      t.string :surname
      t.date :upload_date
      t.integer :status_id
      t.attachment :original_file
      t.attachment :converted_file

      t.timestamps
    end
  end
end
