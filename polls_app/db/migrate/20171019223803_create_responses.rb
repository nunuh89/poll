class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :choice_id
      t.timestamps
    end

    add_index :responses, %i(user_id question_id), unique: true
    add_index :responses, :choice_id
  end
end
