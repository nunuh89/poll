class Question < ApplicationRecord
  has_many :answer_choices

  belongs_to :poll
end
