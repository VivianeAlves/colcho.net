class Rooms::ReviewsController < ApplicationController
  before_action :require_authentication

  def show
    @room = Room.find(params[:id])
    if user_signed_in?
      @user_review = @room.reviews.find_or_initialize_by_user_id(current_user.id)
    end
  end

  def create
    review = room.reviews.find_or_initialize_by_user_id(current_user.id)
    review.update_attributes!(params[:review])
    head :ok
  end

  def update
    create
  end

  private

  def room
    @room ||= Room.find(params[:room_id])
  end
end