class SchoolAdminsController < ApplicationController
  def new
    @school_admin = SchoolAdmin.new
    @school_admin.build_school
  end

  def create
    @school_admin = SchoolAdmin.new(school_admin_params)

    if @school_admin.save
      payload = { admin_id: @school_admin.id, exp: 24.hours.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base)
      cookies[:jwt] = token
      redirect_to school_path(@school_admin.school), notice: "School and admin created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def school_admin_params
    params.require(:school_admin).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation, 
      school_attributes: [:name]
    )
  end
end