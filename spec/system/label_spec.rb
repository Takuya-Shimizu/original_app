require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post_second) { FactoryBot.create(:post_second, user: user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:postlabel) { FactoryBot.create(:postlabel, post: post_second, label: label) }
  before do
    visit new_user_session_path
    fill_in 'メールアドレス',	with: "newuser1@sample.com"
    fill_in 'パスワード', with: 'newuser1'
    click_button 'ログイン'
  end
  describe '新規作成機能' do
    context '新規投稿した場合' do
      it 'その投稿に付けられたラベルが表示される' do
        visit new_post_path
        fill_in 'タイトル', with: 'test'
        fill_in '内容', with: 'test'
        check "test1"
        click_button '登録する'
        expect(page).to have_content 'test1'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意の投稿詳細画面に遷移した場合' do
      it '該当投稿のラベル一覧が表示される' do
        visit posts_path
        click_on '詳細', match: :first
        expect(page).to have_content 'test1'
      end
    end
  end
end
