class ApplicationController < ActionController::Base
  
  helper_method :current_admin, :current_student


  private

  def decoded_token
    token = cookies[:jwt]
    if token
      begin
        JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError, JWT::ExpiredSignature
        nil
      end
    end
  end

  def current_admin
    if decoded_token
      admin_id = decoded_token[0]['admin_id']
      @current_admin ||= SchoolAdmin.find_by(id: admin_id) if admin_id
    end
  end

  def current_student
    if decoded_token
      student_id = decoded_token[0]['student_id']
      @current_student ||= Student.find_by(id: student_id) if student_id
    end
  end

  def require_admin_login
    unless current_admin
      redirect_to login_path, alert: "You must be logged in as a School Admin to access this page."
    end
  end

  def require_student_login
    unless current_student || current_admin
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end