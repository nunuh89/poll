class User < ApplicationRecord
  has_many :authored_polls,
  class_name: :Poll

  has_many :responses
  
end
