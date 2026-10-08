class SchoolsController < ApplicationController
  before_action :require_admin_login
  before_action :set_school, only: %i[show edit update destroy]

  def index
    @schools = School.all
  end

  def show
    @school = School.find(params[:id])
    @students = @school.students
    @school_admins = @school.school_admins
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
    @school = School.new(school_params)

    if @school.save
      redirect_to @school, notice: "School was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @school.update(school_params)
      redirect_to @school, notice: "School was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school.destroy
    redirect_to schools_url, notice: "School was successfully destroyed."
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name)
  end
end