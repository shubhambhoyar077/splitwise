class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :payer, null: false, foreign_key: {to_table: :users}
      t.decimal :total_amount, precision: 10, scale: 2, default: 0
      t.string :description, default: ""
      t.date :date

      t.timestamps
    end
  end
end
