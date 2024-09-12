class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def show
    @rawg_game = RawgService.new.get_game_details(@game.rawg_id) if @game.rawg_id
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, notice: 'Game was successfully deleted.'
  end

  def search
    if params[:query].present?
      @results = RawgService.new.search_games(params[:query])
    else
      @results = []
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :description, :release_date, :rawg_id)
  end
end
