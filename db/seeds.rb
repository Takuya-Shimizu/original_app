users = ["yamada", "abe", "tanaka", "yabe", "kimura"]
users.each_with_index do |user, i|
  User.create(
    name: "#{user}",
    email: "#{i + 1}@gmail.com",
    password: "password"
  )
end