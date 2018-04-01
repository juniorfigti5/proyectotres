class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.attachment :banner
      t.string :url
      t.date :startDate
      t.date :endDate
      t.decimal :value
      t.text :script
      t.text :recomendations

      t.timestamps
    end
  end
end
