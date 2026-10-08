class AttendancesController < ApplicationController
  before_action :require_admin_login
  before_action :set_school_and_student

  def index
    @attendances = @student.attendances.order(date: :desc)
  end

  def new
    @attendance = @student.attendances.new
  end

  def create
    @attendance = @student.attendances.new(attendance_params)

    if @attendance.save
      redirect_to school_student_attendances_path(@school, @student), notice: "Attendance recorded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @attendance = @student.attendances.find(params[:id])
  end

  def update
    @attendance = @student.attendances.find(params[:id])

    if @attendance.update(attendance_params)
      redirect_to school_student_attendances_path(@school, @student), notice: "Attendance updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

 private

def set_school_and_student
  if params[:student_id]
    @student = Student.find(params[:student_id])
  elsif params[:id]
    @attendance = Attendance.find(params[:id])
    @student = @attendance.student
  end

  
  @school = params[:school_id] ? School.find(params[:school_id]) : @student&.school
end

  def attendance_params
    params.require(:attendance).permit(:date, :status)
  end
end