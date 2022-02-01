class Public::WorkSpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_space, only: [:show,:update,:edit,:destroy]

  def new
    @work_space = WorkSpace.new
  end

  def create
    @work_space = WorkSpace.new(work_space_params)
    if @work_space.save
      redirect_to work_space_path(@work_space)
    else
      render :new
    end
  end

  def edit
  end

  def show
    #デバッグ用
    @horons = Horon.where(work_space_id: @work_space.id)
  end

  def update
    if @work_space.update!(work_space_params)
      redirect_to work_space_path(@work_space)
    else
      render :edit
    end
  end

  def destroy
    if @work_space.destroy
      redirect_to user_path(current_user)
    else
      render :show
    end

  end

  private

  def work_space_params
    params.require(:work_space).permit(:name).merge(user_id: current_user.id)
  end

  def set_work_space
    @work_space = WorkSpace.find(params[:id])
  end
end
