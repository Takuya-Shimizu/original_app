require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ユーザーの名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(name: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーのメールアドレスが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(email: '')
        expect(user).not_to be_valid
      end
    end
  end
end