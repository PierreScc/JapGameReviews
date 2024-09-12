# Créer un service pour rechercher les bons `rawg_id`
class RawgService
  include HTTParty
  base_uri 'https://api.rawg.io/api'

  def initialize
    @api_key = '9a87f3b6007e4cae9bddd651062245e8' # Remplace 'YOUR_API_KEY' par ta clé API
  end

  def search_games(query)
    self.class.get("/games", query: { search: query, key: @api_key })
  end

  def get_game_details(id)
    self.class.get("/games/#{id}", query: { key: @api_key })
  end
end

# Recherche manuelle des `rawg_id` pour nos jeux
service = RawgService.new
games_data = [
  { title: "The Legend of Zelda: Breath of the Wild", query: "The Legend of Zelda: Breath of the Wild" },
  { title: "Final Fantasy VII Remake", query: "Final Fantasy VII Remake" },
  { title: "Persona 5", query: "Persona 5" }
]

# Recherche des bons `rawg_id` et mise à jour des jeux avec les détails de l'API RAWG
games_data.each do |data|
  results = service.search_games(data[:query])
  rawg_id = results['results'].first['id']
  data[:rawg_id] = rawg_id

  # Récupération des détails du jeu avec le `rawg_id`
  rawg_game = service.get_game_details(rawg_id)

  # Mise à jour ou création du jeu avec les détails de l'API RAWG
  game = Game.find_or_create_by(title: data[:title])
  game.update(
    rawg_id: rawg_id,
    release_date: rawg_game['released'],
    description: rawg_game['description_raw'],
    image: rawg_game['background_image']
  )
end

# Articles
@articles = Article.create([
  { title: "E3 2024: Highlights", content: "The biggest announcements from E3 2024...", published_at: Time.now },
  { title: "Top 10 JRPGs of All Time", content: "A countdown of the best JRPGs ever made...", published_at: Time.now },
  { title: "Interview with Hideo Kojima", content: "Insights from the legendary game designer...", published_at: Time.now }
])

# Ajout de quelques critiques pour les jeux
Game.all.each do |game|
  Review.create(game: game, source: "Famitsu", score: rand(70..100), review_date: Time.now)
  Review.create(game: game, source: "Metacritic", score: rand(70..100), review_date: Time.now)
end
