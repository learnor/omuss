class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_group, except: [:index, :new, :create]
  before_action :is_admin_of, only: [:edit, :update, :destroy]
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
    @group.user = current_user
    if @group.save
      @group.user.admin!(@group)
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

  def is_admin_of
    @group = Group.find(params[:id])
    if !current_user.is_admin_of?(@group)
      flash[:alert] = "你不是主持人，无权操作！"
      redirect_to :back
    end
  end
end
