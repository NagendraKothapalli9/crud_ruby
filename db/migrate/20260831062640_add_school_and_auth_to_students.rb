class AddSchoolAndAuthToStudents < ActiveRecord::Migration[8.1]
  def change
    add_reference :students, :school, null: true, foreign_key: true
    add_column :students, :password_digest, :string
  end
end
