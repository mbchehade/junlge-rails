require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:all) do
      @takenEmail = User.create(:email => 'testG@test.com', :password => 'password', :password_confirmation => 'password')
    end

    describe 'blank password' do
      it 'should respond with blank password error message' do
        @user = User.create(:email => 'test@test.com', :password => nil, :password_confirmation => 'password')

        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe 'blank password confirmation' do
      it 'should respond with blank password confirmation error message' do
        @user = User.create(:email => 'test@test.com', :password => 'password', :password_confirmation => nil)

        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    describe 'password differs from confirmation' do
      it 'should respond with password and confirmation must be the same error' do
        @user = User.create(:email => 'test@test.com', :password => 'password', :password_confirmation => '')

        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    describe 'email is not unique' do
      it 'should respond with email is not unique error' do
        @user = User.create(:email => 'testG@test.com', :password => 'password', :password_confirmation => 'password')

        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'email is not unique case insensative' do
      it 'should respond with email is not unique error' do
        @user = User.create(:email => 'testg@test.COM', :password => 'password', :password_confirmation => 'password')

        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end
end