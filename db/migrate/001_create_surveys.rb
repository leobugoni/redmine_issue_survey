class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :issue, index: true, foreign_key: true
      t.string :comentario, null: false
      t.integer :nota, null: false
    end
  end
end
