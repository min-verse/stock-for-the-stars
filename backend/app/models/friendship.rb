class Friendship < ApplicationRecord
  belongs_to :user
  # second part of creating a self-referential relationship
  belongs_to :friend, class_name: 'User'
end
