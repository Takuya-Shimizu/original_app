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
        it 'その投稿が表示され、コメントを登録できる' do
          visit new_post_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          click_button '登録する'
          sleep(2)

          fill_in 'comment[content]', with: 'testzzz'
          click_button 'コメント登録する'
          expect(page).to have_content 'testzzz'
        end
      end
    end
    describe 'コメント編集機能' do
      context 'コメント編集リンクを押した場合' do
        it 'コメントを編集できる' do
          visit new_post_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          click_button '登録する'
          sleep(2)

          fill_in 'comment[content]', with: 'testzzz'
          click_button 'コメント登録する'
          click_link 'コメント編集'
          sleep(2)

          click_button '更新する'
          expect(page).to have_content 'testzzz'
        end
      end
    end
    describe 'コメント削除機能' do
      context 'コメント削除リンクを押した場合' do
        it 'コメントを削除できる' do
          visit new_post_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          click_button '登録する'
          sleep(2)

          fill_in 'comment[content]', with: 'testzzz'
          click_button 'コメント登録する'
          click_link 'コメント削除'
          sleep(2)
          page.accept_confirm
          expect(page).to have_content 'コメント一覧'
        end
      end
    end
  end
end