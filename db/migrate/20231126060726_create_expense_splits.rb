class CreateExpenseSplits < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_splits do |t|
      t.references :recipient, null: false, foreign_key: {to_table: :users}
      t.references :expense, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.boolean :recipient_paid, default: false

      t.timestamps
    end
  end
end
