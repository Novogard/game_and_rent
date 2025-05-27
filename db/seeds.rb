# response = Faraday.post("https://id.twitch.tv/oauth2/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=client_credentials")
# p response.status
# p response.headers
# p response.body

response = Faraday.post("https://api.igdb.com/v4/games") do |req|
  req.headers["Client-ID"] = ENV['CLIENT_ID']
  req.headers["Authorization"] = ENV['ACCESS_TOKEN']

  req.body = 'search "Tales of"; fields id, name; limit 50;'
end

results = JSON.parse(response.body)
ids = results.map { |game| game["id"] }


CONDITIONS = %w(Bad OK Good Mint)
STATUS = %w(Pending Accepted Rejected)

puts "Cleaning DB"
User.destroy_all
Offer.destroy_all
Booking.destroy_all
puts "DB cleaned"

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
    game_id: ids.sample,
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
