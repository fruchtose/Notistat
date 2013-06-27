require 'spec_helper'

describe Users::NoticesController do
  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  it "should get show" do
    get :show, user_id: @user
    assert_response :success
  end

  it "should get new" do
    get :new, user_id: @user
    assert_response :redirect
  end
end
