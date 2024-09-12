class ReviewsController < ApplicationController
  before_action :set_game

  def new
    @review = @game.reviews.build
  end

  def create
    @review = @game.reviews.build(review_params)
    if @review.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def edit
    @review = @game.reviews.find(params[:id])
  end

  def update
    @review = @game.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @review = @game.reviews.find(params[:id])
    @review.destroy
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def review_params
    params.require(:review).permit(:source, :score, :review_date)
  end
end
