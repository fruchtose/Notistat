class NoticesController < ApplicationController
  before_filter :check_for_user

  private
    def check_for_user
      @user = User.find_by_id(params[:user])
      render :status => :unauthorized unless @user
    end
end