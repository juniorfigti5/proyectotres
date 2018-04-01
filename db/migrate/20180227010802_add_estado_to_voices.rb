class AddEstadoToVoices < ActiveRecord::Migration[5.0]
  def change
    add_column :voices, :estado, :text
  end
end
