class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  TASK_STATUS = ['new', 'in-progress', 'completed'].freeze

  validates :title, presence: true, length: { minimum: 8 }
  validates :status, inclusion: { in: TASK_STATUS }
end
