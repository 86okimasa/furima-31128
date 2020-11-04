require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe '新規登録' do
    context '新規登録がうまくいくとき' do
      it "ユーザー情報及び本人確認の項目が全て存在すれば登録できる" do
        expect(@user).to be_valid
      end
      # it "emailが一意性であれば登録できる" do
      # end
      # it "emailに@が含まれていれば登録できる" do
      # end
      it "passwordが６文字以上なら登録できる" do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
      # it "passwordが半角英数混合で入力されていれば登録できる"　do
      # end
      # it "passwordは確認用を含めて2回入力されていれば登録できる"　do
      # end
      # it  "パスワードと確認用パスワードの値が一致していれば登録できる"　do
      # end
      # it "本名は全角（漢字、カタカナ、ひらがな）で入力されていれば登録できる" do
      # end
      # it "フリガナは全角カタカナで入力されていれば登録できる" do
      # end
    end

    context '新規登録がうまくいかないとき' do
      it "ニックネームが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "パスワードが空だと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "苗字が空だと登録できない" do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "名前が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "苗字のフリガナが空だと登録できない" do
        @user.family_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family kana can't be blank")
      end
      it "名前のフリガナが空だと登録できない" do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana can't be blank")
      end
      it "誕生日が空だと登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it "emailに一意性がないと登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "アドレスに@が含まれていないと登録できない" do
        @user.email = "aaaagmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが5文字以下だと登録できない" do
        @user.password = "123ab"
        @user.password_confirmation = "123ab"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードが半角英数混合でないと登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードと確認用パスワードの値が一致していないと登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "本名が全角（漢字、カタカナ、ひらがな）以外での入力だと登録できない" do
        @user.family_name = "aaaaa"
        @user.first_name = "aaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角（漢字、カタカナ、ひらがな）を使用してください", "First name 全角（漢字、カタカナ、ひらがな）を使用してください")
      end
      it "フリガナが全角カタカナ以外での入力だと登録できない" do
        @user.family_kana = "あああああ"
        @user.first_kana = "あああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family kana 全角カタカナを使用してください", "First kana 全角カタカナを使用してください")
      end
    end
  end
end
