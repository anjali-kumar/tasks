class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :parent, class_name: 'Task', optional: true

  has_many :subtasks, class_name: 'Task', foreign_key: "parent_id", dependent: :destroy                            
  
  TASK_STATUS = ['new', 'in-progress', 'completed'].freeze

  validates :title, presence: true, length: { minimum: 8 }
  validates :status, inclusion: { in: TASK_STATUS }
end
