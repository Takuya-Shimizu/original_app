# users = ["yamada", "abe", "tanaka", "yabe", "kimura"]
# users.each_with_index do |user, i|
#   User.create(
#     name: "#{user}",
#     email: "#{i + 1}@gmail.com",
#     password: "password"
#   )
# end

require "csv"
 
CSV.foreach('db/genre.csv') do |info|
  Genre.create(:name => info[0])
end

CSV.foreach('db/label.csv') do |info|
  Label.create(:name => info[0])
end