require 'spec_helper'

describe Users::NoticesController do
  before :each do
    @user = FactoryGirl.create :user
  end

  after :each do
    sign_out @user
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

  context 'when a user has no notice' do
    it 'should show status as :off' do
      sign_in @user
      get :show, format: :json, user_id: @user
      assert_response :success

      response.body.should_not be_nil
      body = JSON.parse(response.body)
      notice = Notice.new(body['notice'])
      notice.status.should == false
      notice.to_s.should == 'off'
    end
  end

  context 'when a user has a notice' do
    before :each do
      sign_in @user
      @notice = @user.notice
      @notice.save
    end

    after :each do
      @notice.delete
    end

    it 'should show status as :off by default' do
      get :show, format: :json, user_id: @user
      assert_response :success

      response.body.should_not be_nil
      body = JSON.parse(response.body)
      notice = Notice.new(body['notice'])
      notice.status.should == false
      notice.to_s.should == 'off'
    end

    it 'can show status as :on' do
      @notice.status = true
      @notice.save
      get :show, format: :json, user_id: @user
      assert_response :success

      response.body.should_not be_nil
      body = JSON.parse(response.body)
      notice = Notice.new(body['notice'])
      notice.status.should == true
      notice.to_s.should == 'on'
    end
  end
end
