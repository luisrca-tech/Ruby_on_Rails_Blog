class Post < ApplicationRecord
  validates_presence_of :title, :description

  belongs_to :user
end
