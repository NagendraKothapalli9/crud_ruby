class StudentsController < ApplicationController
 
  before_action :require_student_login, only: [:index, :show, :update]
  before_action :require_admin_login, only: [:new, :edit, :destroy]

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_school, only: [:new, :create]

  def index
    @student = current_student
    @attendances = @student.attendances.order(date: :desc)
  end
  
  def show
    @attendances = @student.attendances
  end

  def new
    @student = @school.students.new
  end

  def edit
  end

  def create
    @student = @school.students.new(student_params)
    if @student.save
      redirect_to school_path(@school), notice: "Student created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      
      redirect_to @student, notice: "Profile picture updated successfully."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    school = @student.school
    @student.destroy
    redirect_to school_path(school), notice: "Student deleted successfully."
  end

  private

  def set_student
    @student = Student.find(params[:id])
    @school = @student.school
  end

  def set_school
    @school = School.find(params[:school_id]) if params[:school_id]
  end

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation, :age, :course, :school_id, :profile_picture)
  end
end