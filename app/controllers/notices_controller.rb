class NoticesController < ApplicationController
  before_filter :check_for_user!

  private
    def check_for_user!
      authenticate_user! unless admin_signed_in?
    end
end