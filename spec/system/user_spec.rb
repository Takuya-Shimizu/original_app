require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規登録機能' do
    before do
      FactoryBot.create(:user)
    end

    context 'ユーザーを新規作成した場合' do
      it '投稿一覧画面が表示される' do
        visit new_user_registration_path
        fill_in '名前', with: 'newuser2'
        fill_in 'メールアドレス', with: 'newuser2@sample.com'
        fill_in 'パスワード', with: 'newuser2'
        fill_in '確認用パスワード', with: 'newuser2'
        click_on 'アカウント登録'
        
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end

    context 'ログインせず投稿一覧画面に飛ぼうとした場合' do
      it '投稿一覧画面が表示される' do
        visit new_user_registration_path
        visit posts_path
        expect(current_path).to eq posts_path
      end
    end
  end

  describe 'セッション機能' do
    before do
      FactoryBot.create(:user)

      visit new_user_session_path
      fill_in 'メールアドレス', with: 'newuser1@sample.com'
      fill_in 'パスワード', with: 'newuser1'   
      click_button 'ログイン'
    end
    context 'ログインした場合' do
      it '自分の詳細画面に飛べる' do
        click_on 'マイページ'
        expect(page).to have_content 'のページ'
      end
    end
    context 'ログインした場合' do
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        FactoryBot.create(:user_second)
        visit user_path(User.last.id)
        expect(page).to have_content 'アクセス権限がありません'
      end
    end
    context 'ログアウトをした場合' do
      it 'ログアウト可能である' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:user_first)
      visit new_user_session_path
    end  
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできる' do
        fill_in 'メールアドレス', with: 'newuser11@sample.com'
        fill_in 'パスワード', with: 'newuser11'

        click_button 'ログイン'
        
        click_on '管理画面へ'
        sleep(2)
        
        expect(page).to have_content 'サイト管理'
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面にアクセスできないこと' do
        FactoryBot.create(:user)
        fill_in 'メールアドレス',	with: "newuser1@sample.com"
        fill_in 'パスワード',	with: 'newuser1'
        click_button 'ログイン'
        expect(page).not_to have_content '管理画面へ'
      end
    end
  end
end
