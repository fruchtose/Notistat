class Users::NoticesController < ApplicationController
  before_filter :check_for_user!

  # GET /users/1/notice
  # GET /users/1/notice.json
  def show
    @user = User.find(params[:user_id])
    @notice = @user.notice

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /users/1/notice/new
  # GET /users/1/notice/new.json
  def new
    respond_to do |format|
      if @user.notice
        @notice = @user.notice
        url = url_for([:edit, @user, :notice])
        format.html {redirect_to url, notice: 'A notice already exists for this user.'}
      else
        format.html # new.html.erb
      end
      
      format.json { render json: @notice }
    end
  end

  # GET /users/1/notice/edit
  def edit
    @user = User.find(params[:user_id])
    @notice = @user.notice
  end

  # POST /users/1/notice
  # POST /users/1/notice.json
  def create
    respond_to do |format|
      if inner_update
        url = url_for([:edit, @user, :notice])
        format.html { redirect_to url, notice: "Notice was successfully created as #{@notice}." }
        format.json { render json: @notice, status: :created, location: @notice }
      else
        format.html { render action: "new" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/notice
  # PUT /users/1/notice.json
  def update
    respond_to do |format|
      if inner_update
        url = url_for([:edit, @user, :notice])
        format.html { redirect_to url, notice: "Notice was successfully updated to #{@notice}." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/notice
  # DELETE /users/1/notice.json
  def destroy
    @user = User.find(params[:user_id])
    @notice = @user.notice
    @notice.delete

    respond_to do |format|
      format.html { redirect_to notices_url }
      format.json { head :no_content }
    end
  end

  private
    def inner_update
      @user = User.find(params[:user_id])
      @notice = @user.notice || Notice.new
      notice_params = {status: false, user: @user}.merge!((params[:notice] || {}).slice(:status))
      @notice.update(notice_params)
    end

    def check_for_user!
      authenticate_user! unless user_signed_in?
    end
end
