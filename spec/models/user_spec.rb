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

    after(:all) do
      User.delete(@takenEmail.id)
    end

  end

  describe '.authenticate_with_credentials' do
    before(:all) do
      @user = User.create(:email => 'Testy@teSt.com', :password => 'password', :password_confirmation => 'password')
    end

    describe 'correct email and password' do
      it 'should return the user object' do
        @session = @user.authenticate_with_credentials('testy@test.com', 'password')

        expect(@session).to eql(@user)
      end
    end

    describe 'incorrect email and password' do
      it 'should return nil' do
        @session = @user.authenticate_with_credentials('testy@test.com', 'not the password')

        expect(@session).to be_nil
      end
    end

    describe 'correct email and password but case insensitive email' do
      it 'should return the user object' do
        @session = @user.authenticate_with_credentials('testy@test.COM', 'password')

        expect(@session).to eql(@user)
      end
    end

    describe 'correct email and password but white space around email' do
      it 'should return the user object' do
        @session = @user.authenticate_with_credentials('  testy@test.com  ', 'password')

        expect(@session).to eql(@user)
      end
    end

    after(:all) do
      User.delete(@user.id)
    end

  end
end