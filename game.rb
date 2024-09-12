class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def update_from_rawg(rawg_id)
    rawg_service = RawgService.new
    rawg_game = rawg_service.get_game_details(rawg_id)

    if rawg_game
      self.rawg_id = rawg_id
      self.description = rawg_game['description_raw']
      self.save
    end
  end
end
