FactoryBot.define do
  factory :post do
    title { 'test_title_1' }
    content { 'test_content' }
  end

  factory :post_first, class: Post do
    title { '2' }
    content { '2' }
  end

  factory :post_second, class: Post do
    title { 'test_title_999' }
    content { 'test_content_999' }
    # after(:build) do |post|
    #   label = create(:label)
    #   post.postlabels << build(:postlabels, post: post_second, label: label)
    # end
  end
end
