class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy, :start_task, :complete_task]
  
    def index
      @tasks = Task.all
    end
  
    def show
    end
  
    def new
      @task = Task.new
    end
  
    def edit
    end
  
    def create
      @task = Task.new(task_params)
  
      if @task.save
        redirect_to @task, notice: 'Tarea creada correctamente.'
      else
        render :new
      end
    end
  
    def update
      if @task.update(task_params)
        redirect_to @task, notice: 'Tarea actualizada correctamente.'
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_url, notice: 'Tarea eliminada correctamente.'
    end
  
    def start_task
      @task.start! if @task.may_start?
      redirect_to @task
    end
  
    def complete_task
      @task.complete! if @task.may_complete?
      redirect_to @task
    end
  
    private
      def set_task
        @task = Task.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :description, :due_date, :status)
      end
  end  