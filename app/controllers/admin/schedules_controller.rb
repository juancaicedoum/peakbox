# app/controllers/admin/schedules_controller.rb
class Admin::SchedulesController < ApplicationController
  before_action :authenticate_user! 
  before_action :authorize_admin! 
  # ELIMINA la línea: before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = Schedule.all.order(date: :desc, start_time: :asc)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to admin_schedules_path, notice: 'Horario creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @schedule = Schedule.find(params[:id]) # <-- Añadir esta línea
  end

  def update
    @schedule = Schedule.find(params[:id]) # <-- Añadir esta línea
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path, notice: 'Horario actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id]) # <-- Añadir esta línea
    @schedule.destroy
    redirect_to admin_schedules_path, notice: 'Horario eliminado exitosamente.', status: :see_other
  end

  private

  # ELIMINA el método set_schedule completo (ya no lo necesitamos si lo quitamos del before_action)
  # def set_schedule
  #   @schedule = Schedule.find(params[:id])
  # end

  def schedule_params
    params.require(:schedule).permit(:name, :start_time, :end_time, :capacity, :date, :enabled)
  end
end