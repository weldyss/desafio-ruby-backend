class AddTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.datetime :transacted_at
      t.float :amount
      t.string :cpf
      t.string :credit_card
      t.string :store_owner
      t.string :store_name

      t.timestamps
    end
  end
end
