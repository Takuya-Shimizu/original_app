require 'rails_helper'

RSpec.describe '投稿モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context '投稿のタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        post = Post.new(title: '', content: '失敗テスト1', user_id: user.id)
        expect(post).not_to be_valid
      end
    end
    context '投稿の詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        post = Post.new(title: '失敗テスト2', content: '', user_id: user.id)
        expect(post).not_to be_valid
      end
    end
    context '投稿のタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        post = Post.new(title: '成功!', content: '成功!', user_id: user.id)
        expect(post).to be_valid
      end
    end
    context 'contentの文字数が400字以内の場合' do
      it 'バリデーションが通る' do
        post = Post.new(title: '成功!', content: 'a' * 400, user_id: user.id)
        expect(post).to be_valid
      end
    end
    context 'contentの文字数が401字以上の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(title: '成功!', content: 'a' * 401, user_id: user.id)
        expect(post).not_to be_valid
      end
    end
  end
end