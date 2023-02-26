users = ["Kimura", "Abe", "Tanaka", "Sato", "Shimizu"]
users.each_with_index do |user, i|
  User.create(
    name: "#{user}",
    email: "#{i + 1}@gmail.com",
    password: "password"
  )
end

require "csv"
 
# CSV.foreach('db/genre.csv') do |info|
#   Genre.create(:name => info[0])
# end

CSV.foreach('db/label.csv') do |info|
  Label.create(:name => info[0])
end

5.times do |i|
  post = Post.create(
    title: "test_title#{i + 1}",
    content: "test_content#{i + 1}",
    user_id: "#{i + 1}",
  )

  Postlabel.create(
    label_id: (i + 1),
    post_id: post.id
  )
end

# post = Post.create(title: 'test990', content: 'test990')
Comment.create([
  { post_id: '1', user_id: '2', content: 'test_comment_by_user_id_2'},
  { post_id: '2', user_id: '3', content: 'test_comment_by_user_id_3'},
  { post_id: '3', user_id: '4', content: 'test_comment_by_user_id_4'},
  { post_id: '4', user_id: '5', content: 'test_comment_by_user_id_5'},
  { post_id: '5', user_id: '1', content: 'test_comment_by_user_id_1'},
])
