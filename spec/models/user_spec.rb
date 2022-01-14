require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it 'should check match of password and password_confirmation' do
      @user = User.create({
        first_name: 'Harry',
        last_name: 'Potter',
        email: 'harry2@hogwarts.com',
        password: 'abcd',
        password_confirmation: '6789'
      })

      expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should check if email already exists' do
      @user1 = User.create({
        first_name: 'Ron',
        last_name: 'W',
        email: 'ron2@hogwarts.com',
        password: '6789',
        password_confirmation: '6789'
      })
      
      
      @user2 = User.create({
        first_name: 'Ron',
        last_name: 'W',
        email: 'RON2@hogwarts.com',
        password: '6789',
        password_confirmation: '6789'
      })
        
      expect(@user2.errors.messages[:email]).to include("has already been taken")
    end

    it 'should check for presence of first name' do
      @user = User.create({
        first_name: nil,
        last_name: 'Potter',
        email: 'harry2@hogwarts.com',
        password: '6789',
        password_confirmation: '6789'
      })

      expect(@user.errors.messages[:first_name]).to include("can't be blank")
    end

    it 'should check for presence of last name' do
      @user = User.create({
        first_name: 'Harry',
        last_name: nil,
        email: 'harry2@hogwarts.com',
        password: '6789',
        password_confirmation: '6789'
      })

      expect(@user.errors.messages[:last_name]).to include("can't be blank")
    end

    it 'should check for presence of email' do
      @user = User.create({
        first_name: 'Harry',
        last_name: 'Potter',
        email: nil,
        password: '6789',
        password_confirmation: '6789'
      })

      expect(@user.errors.messages[:email]).to include("can't be blank")
    end

    it 'should minimum length of password' do
      @user = User.create({
        first_name: 'Harry',
        last_name: 'Potter',
        email: 'harry2@hogwarts.com',
        password: '678',
        password_confirmation: '678'
      })

      expect(@user.errors.messages[:password]).to include("is too short (minimum is 4 characters)")
    end

  end

  describe '.authenticate_with_credentials' do

    before(:each) do
      @user = User.create({
        first_name: 'Harry',
        last_name: 'Potter',
        email: 'harry2@hogwarts.com',
        password: 'abcd',
        password_confirmation: 'abcd'
      })
    end

    it 'should return user instance if authenticated' do
      user = User.authenticate_with_credentials(@user.email, @user.password)

      expect(user[:id]).to equal(User.last[:id])
    end

    it 'should return nil if user not valid' do
      user = User.authenticate_with_credentials(@user.email, 'wrong_password')

      expect(user).to equal(nil)
    end
    
    it 'should allow login for trailing whitespace in email' do
      user = User.authenticate_with_credentials(" #{@user.email} ", @user.password)

      expect(user[:id]).to equal(User.last[:id])
    end
    
    it 'should allow login for wrong letter case in email' do
      user = User.authenticate_with_credentials('HARRY2@hogwarts.COM', @user.password)

      expect(user[:id]).to equal(User.last[:id])
    end
  end

end
