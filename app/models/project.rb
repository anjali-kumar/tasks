class Project < ApplicationRecord
  # belongs_to :user
  belongs_to :creator, class_name: 'User'
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, length: { minimum: 4 }
end
