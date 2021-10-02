class AddAuthorToTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :author, foreign_key: {to_table: :users}
    change_column_null :tickets, :author_id, false
  end
end
