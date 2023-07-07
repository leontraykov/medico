class RemoveFieldsFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :sender_id, :integer
    remove_column :messages, :recipient_id, :integer
  end
end
