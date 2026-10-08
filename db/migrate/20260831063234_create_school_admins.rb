class CreateSchoolAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :school_admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
