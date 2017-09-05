class CreateVisitors < ActiveRecord::Migration[5.1]
  def change
    create_table :visitors do |t|
      t.string :ip
      t.integer :visits

      t.timestamps
    end
  end
end
