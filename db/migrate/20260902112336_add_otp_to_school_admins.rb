class AddOtpToSchoolAdmins < ActiveRecord::Migration[8.1]
  def change
    add_column :school_admins, :otp_code, :string
    add_column :school_admins, :otp_sent_at, :datetime
  end
end
