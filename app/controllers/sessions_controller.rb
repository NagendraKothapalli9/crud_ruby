class SessionsController < ApplicationController
  def new
  end

  def create
    admin = SchoolAdmin.find_by(email: params[:email])
    student = Student.find_by(email: params[:email])

    if admin && admin.authenticate(params[:password])
     
      payload = { admin_id: admin.id, exp: 24.hours.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base)
      
      cookies[:jwt] = token
      redirect_to school_path(admin.school)
      
    elsif student && student.authenticate(params[:password])
      payload = { student_id: student.id, exp: 24.hours.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base)
      
      cookies[:jwt] = token
      redirect_to school_students_path(student.school)
      
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    cookies.delete(:jwt)
    redirect_to login_path
  end
end