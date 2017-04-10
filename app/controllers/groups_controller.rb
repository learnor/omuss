class GroupsController < ApplicationController

  before_action :find_group, except: [:index, :new, :create]
  def index
    @groups = Group.all
  end

  def show
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to "/"
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to "/"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to "/"
  end

  private

  def group_params
    params.require(:group).permit(:title, :description, :room, :password)
  end

  def find_group
    @group = Group.find(params[:id])
  end
end
