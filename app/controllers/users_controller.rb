class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy, :report]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_manager_user, only: [:destroy, :index]

  # GET /users or /users.json
  def index
    @user = User.new
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    session[:actual_user] = params[:id]
    @jogtime = Jogtime.new
    if session[:order] == 1
      @jogtimes = @user.jogtimes.order(weekday: :desc).paginate(page: params[:page])
    else
      @jogtimes = @user.jogtimes.order(:weekday).paginate(page: params[:page])
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        if session[:user_id].nil?
          log_in @user
          flash[:success] = "Account was succesfully created!"
          format.html { redirect_to @user }
          format.json { render :show, status: :created, location: @user }
        else
          flash[:success] = "Account was succesfully created!"
          format.html { redirect_to users_url }
          format.json { render :show, status: :created, location: @user }
        end
      else
        if session[:user_id].nil?
          @user.errors.full_messages.each do |msg|
            flash[:danger] = msg
          end
          format.html { redirect_to signup_path, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        else
          @user.errors.full_messages.each do |msg|
            flash[:danger] = msg
          end
          format.html { redirect_to users_path, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end  
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Account was succesfully updated!"
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        @user.errors.full_messages.each do |msg|
          flash[:danger] = msg
        end
        format.html { redirect_to edit_user_path, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:danger] = "Account was succesfully destroyed!"
      format.html { redirect_to users_url}
      format.json { head :no_content }
    end
  end

  # Sort the jogging times by dates
  def order
    if session[:order] == 1
      session[:order] = 0
    else 
      session[:order] = 1
    end
    redirect_to actual_user
  end

  # Create a report for the last week
  def report
    @totalMinutes = 0
    @totalKm = 0
    num = 0
    totalSpeed = 0
    (0..6).each do |i|
      date = i.day.ago
      dates = Jogtime.where(weekday: date, user_id: current_user.id)
      dates.each do | item |
        speed = (item.distance / (item.minutes.to_f/60)).round(3)
        num += 1
        totalSpeed += speed
        @totalMinutes += item.minutes
        @totalKm += item.distance
      end
    end
    if num != 0
      @avgSpeed = (totalSpeed / num).round(3)
      @avgDistance = (@totalKm / num).round(3)
    else 
      @avgSpeed = 0
      @avgDistance = 0
    end
    @nums = num
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin? || current_user.manager?
    end

    # Check if a user is admin.
    def admin_manager_user
      redirect_to(root_url) unless current_user.admin? || current_user.manager?
    end
  
end
