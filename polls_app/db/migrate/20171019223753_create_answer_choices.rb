class CreateAnswerChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_choices do |t|
      t.integer :question_id
      t.text :choice_text
      t.timestamps
    end

    add_index :answer_choices, :question_id
    add_index :answer_choices, :choice_text
  end
end
