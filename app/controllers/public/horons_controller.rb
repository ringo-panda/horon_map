class Public::HoronsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_space
  before_action :set_horon, only: [:show, :update, :edit,:destroy, :destroy_all]

  def new
    @horon = Horon.new
  end

  def create
    @horon = Horon.new(horon_params)
    begin
      ActiveRecord::Base.transaction do
        @horon.save!
        if @horon.parent_id.blank?
          if @work_space.root_id.present?
          previous_root_horon = Horon.find(@work_space.root_id)
          previous_root_horon.update!(parent_id: @horon.id)
          end
          @work_space.update!(root_id: @horon.id)
        end
      end
      redirect_to work_space_horon_path(@work_space, @horon)
    rescue => exception
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        if @horon.parent_id.blank? && params[:horon][:parent_id].present?
          next_root_horon = Horon.find(params[:horon][:parent_id])
          next_root_horon.update!(parent_id: nil)
          @work_space.update!(root_id: next_root_horon.id)
        elsif params[:horon][:parent_id].blank? && @horon.parent_id.present?
          previous_root_horon = Horon.find(@work_space.root_id)
          previous_root_horon.update!(parent_id: @horon.id)
          @work_space.update!(root_id: @horon.id)
        end
        @horon.update!(horon_params)
      end
      redirect_to work_space_horon_path(@work_space, @horon) and return
    rescue => exception
      render :edit
    end
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        if @horon.parent_id.blank?
          if @horon.children.count.zero?
            @work_space.update!(root_id: nil)
          else
            first_child = @horon.children.first
            if @horon.children.count > 1
              child_array = []
              child_array.push(first_child)
              children = @horon.children - child_array
              children.each do |c|
                c.update!(parent_id: first_child.id)
              end
            end
            first_child.update!(parent_id: nil)
            @work_space.update!(root_id: first_child.id)
          end
        elsif @horon.children.count > 0
          children = @horon.children
          children.each do |c|
            c.update!(parent_id: @horon.parent_id)
          end
        end
        @horon.destroy!
      end
      if Horon.where(work_space_id: @work_space.id).count.zero?
        redirect_to work_space_path(@work_space) and return
      else
        @horon = Horon.find(@work_space.root_id)
        redirect_to work_space_horon_path(@work_space, @horon) and return
      end
    rescue => exception
      redirect_to work_space_path(@work_space) and return
    end
  end

  def destroy_all
    begin
      ActiveRecord::Base.transaction do
        if @horon.parent_id.blank?
          @work_space.update!(root_id: nil)
        end
        search_and_destroy_child(@horon)
        if Horon.where(work_space_id: @work_space.id).count.zero?
          redirect_to work_space_path(@work_space) and return
        else
          @horon = Horon.find(@work_space.root_id)
          redirect_to work_space_horon_path(@work_space, @horon) and return
        end
      end
    rescue => exception
      redirect_to work_space_path(@work_space) and return
    end
  end

  private
  def horon_params
    params.require(:horon).permit(:name, :parent_id).merge(last_update_user_id: current_user.id, work_space_id: params[:work_space_id])
  end

  def set_work_space
    @work_space = WorkSpace.find_by(id: params[:work_space_id])
  end

  def set_horon
    @horon = Horon.find(params[:id])
  end

  def search_and_destroy_child(horon)
    unless horon.children.count.zero?
      horon.children.each do |h|
        search_and_destroy_child(h)
      end
    end
    horon.destroy!
  end
end
