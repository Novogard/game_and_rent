# response = Faraday.post("https://id.twitch.tv/oauth2/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=client_credentials")
# p response.status
# p response.headers
# p response.body


puts "Cleaning DB"
User.destroy_all
Offer.destroy_all
Booking.destroy_all
puts "DB cleaned"

puts "Creating games"

response = Faraday.post("https://api.igdb.com/v4/games/") do |req|
  req.headers["Client-ID"] = ENV['CLIENT_ID']
  req.headers["Authorization"] = ENV['ACCESS_TOKEN']

  req.body = 'search "Legend"; where platforms != null & genres != null; fields id, name, platforms, summary, genres, cover.image_id ; limit 50;'
end

results = JSON.parse(response.body)
games = results.to_a

games.each do |game|
  Game.create!({
    title: game['name'],
    platform: game['platforms'][0],
    overview: game['summary'],
    genre: game['genres'][0],
    artwork_url: "https://images.igdb.com/igdb/image/upload/t_1080p/#{game['cover']['image_id']}.jpg"
  })
end

platform_ids = Game.pluck(:platform).uniq

platform_response = Faraday.post("https://api.igdb.com/v4/platforms/") do |req|
  req.headers["Client-ID"] = ENV['CLIENT_ID']
  req.headers["Authorization"] = ENV['ACCESS_TOKEN']

  req.body = "where id = (#{platform_ids.join(',')}); fields id, name; limit 50;"
end

platforms = JSON.parse(platform_response.body)

genre_ids = Game.pluck(:genre).uniq
genre_response = Faraday.post("https://api.igdb.com/v4/genres") do |req|
  req.headers["Client-ID"] = ENV['CLIENT_ID']
  req.headers["Authorization"] = ENV['ACCESS_TOKEN']

  req.body = "where id = (#{genre_ids.join(',')}); fields id, name; limit 50;"
end

genres = JSON.parse(genre_response.body)

platform_names = platforms.each_with_object({}) { |platform, hash| hash[platform['id']] = platform['name'] }
genre_names = genres.each_with_object({}) { |genre, hash| hash[genre['id']] = genre['name'] }

Game.all.each do |video_game|
  video_game.platform = platform_names[video_game.platform.to_i]
  video_game.genre = genre_names[video_game.genre.to_i]
  video_game.save!
end

puts "Games created"

CONDITIONS = %w(Bad OK Good Mint)
STATUS = %w(Pending Accepted Rejected)


puts "Creating the best users"
User.create!({
  first_name: "Lorenz",
  last_name: "Houzé",
  nickname: "The CEO",
  address: "Here",
  email: "ceo@oftheworld.com",
  password: "password!!!"
})


User.create!({
  first_name: "Mohamed",
  last_name: "Hedi",
  nickname: "The silent coder",
  address: "There",
  email: "sound@ofsilence.com",
  password: "AZERTY!!!"
})


User.create!({
  first_name: "Aude",
  last_name: "Ahuat",
  nickname: "The designer",
  address: "Everywhere",
  email: "colors@oftheweb.com",
  password: "12345!!!"
})

User.create!({
  first_name: "Chahnez",
  last_name: "Zurawicz",
  nickname: "The savior",
  address: "Strawberry fields",
  email: "save@everyone.com",
  password: "6789!!!"
})

puts "Users created"

puts "Creating offers"

15.times do
  Offer.create!({
    description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote,
    rate_per_day: (0..10).to_a.sample,
    condition: CONDITIONS.sample,
    game: Game.all.sample,
    user: User.all.sample
  })
end

puts "Offers created"

puts "Creating bookings"

10.times do
  start = Faker::Date.forward(days: rand(1..21))
  finish = start + rand(1..7).days

  Booking.create!({
    user: User.all.sample,
    offer: Offer.all.sample,
    status: STATUS.sample,
    start_date: start,
    end_date: finish
  })
end

puts "Bookings created"
