class RoomsController < ApplicationController
  before_action :require_authentication, only: [:show, :edit, :update, :destroy]

  def index
    @search_query = params[:q]
    rooms = Room.search(@search_query).page(params[:page]).per(5)
    @rooms = RoomCollectionPresenter.new(rooms.most_recent, self)
  end

  def show
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end


  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "Quarto criado"
    else
      render :new
    end
  end

  def update
    @room = current_user.rooms.find(params[:id])
    if @room.update_attributes(room_params)
      redirect_to @room, :notice => "Quarto atualizado!"
    else
      render :action => "edit"
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
  end

  private

  def set_room
    redirect_to rooms_url
  end

  def room_params
    params.require(:room).permit(:title, :location, :description, :picture)
  end

end