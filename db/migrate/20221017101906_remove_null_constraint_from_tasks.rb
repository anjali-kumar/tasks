class RemoveNullConstraintFromTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tasks, :assignee_id, true
    change_column_null :tasks, :project_id, true
  end
end
