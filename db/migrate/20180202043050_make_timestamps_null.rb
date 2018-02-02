class MakeTimestampsNull < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :artists, :created_at, true
  	change_column_null :artists, :updated_at, true

  	change_column_null :albums, :created_at, true
  	change_column_null :albums, :updated_at, true

  	change_column_null :tracks, :created_at, true
  	change_column_null :tracks, :updated_at, true
  end
end
