require 'spec_helper'

describe Users::NoticesController do
  before :each do
    @user = FactoryGirl.create :user
  end

  context 'when a user is signed out' do
    it 'should redirect :show to login' do
      get :show, user_id: @user
      assert_response :redirect
    end

    it 'should redirect :new to login' do
      get :new, user_id: @user
      assert_response :redirect
    end
  end

  context 'when a user is signed in' do
    before :each do
      sign_in @user
    end

    it "should get :show" do
      get :show, user_id: @user
      assert_response :success
    end

    it "should get :new" do
      get :new, user_id: @user
      assert_response :success
    end
  end
  context 'when a user has no notices' do
    before :each do
      sign_in @user
      #@user.notice.delete if @user.notice
    end
    it 'should show status as :off' do
      get :show, format: :json, user_id: @user
      assert_response :success
    end
  end
end
