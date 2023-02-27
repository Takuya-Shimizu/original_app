require 'rails_helper'
RSpec.describe '投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post_second) { FactoryBot.create(:post_second, user: user) }
  # let!(:postlabels) { FactoryBot.create(:postlabels, post: post_second, label: label) }
  describe do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス',	with: "newuser1@sample.com"
      fill_in 'パスワード', with: 'newuser1'
      click_button 'ログイン'
    end
    describe '新規投稿機能' do
      context '新規投稿した場合' do
        it 'その投稿が表示される' do
          visit new_post_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          click_button '登録する'
          expect(page).to have_content 'test'
        end
      end
    end
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みの投稿一覧が表示される' do
          post = FactoryBot.create(:post, title: 'post1', user_id: user.id)
          visit posts_path
          expect(page).to have_content 'post1'
        end
      end
    end
    describe '詳細表示機能' do
      context '任意の投稿詳細画面に遷移した場合' do
        it 'その投稿の内容が表示される' do
          post = FactoryBot.create(:post, user_id: user.id)
          visit post_path(post)
          expect(page).to have_content 'test'
        end
      end
    end
  end
end