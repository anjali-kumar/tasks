class AddReferencesToProjects < ActiveRecord::Migration[7.0]
  def change
    remove_reference :projects, :user, index: true, foreign_key: true
    add_reference :projects, :creator, null: false, foreign_key: { to_table: :users }
  end
end
