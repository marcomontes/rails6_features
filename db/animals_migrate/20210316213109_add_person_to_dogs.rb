class AddPersonToDogs < ActiveRecord::Migration[6.1]
  def change
    add_column :dogs, :person_id, :integer
  end
end
