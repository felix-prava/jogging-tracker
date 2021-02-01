class JogtimesController < ApplicationController
    before_action :set_jogtime, only: %i[ show edit update destroy ]
    before_action :logged_in_user
    before_action :correct_user, only: [:edit, :new, :update, :destroy]
    before_action :create_user, only: [:create]

    def create
        @jogtime = actual_user.jogtimes.build(jogtime_params)
        respond_to do |format|
            if @jogtime.save
                flash[:success] = "Jogging time added!"
                format.html { redirect_to actual_user }
                format.json { render :show, status: :created, location: @jogtime }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @jogtime.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @jogtime = Jogtime.find(params[:id])
        user = @jogtime.user
        @jogtime.destroy

        respond_to do |format|
        format.html { redirect_to user }
        format.json { head :no_content }
        end
    end
    
    def edit
    end

    def update 
        respond_to do |format|
            if @jogtime.update(jogtime_params)
              flash[:success] = "Jogging time was succesfully updated!"
              format.html { redirect_to @jogtime.user }
              format.json { render :show, status: :ok, location: @jogtime }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @jogtime.errors, status: :unprocessable_entity }
            end
        end
    end

    private

        # Use callbacks to share common setup or constraints between actions.
        def set_jogtime
            @jogtime = Jogtime.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def jogtime_params
            params.require(:jogtime).permit(:minutes, :distance, :weekday)
        end

        # Confirms the correct user.
        def correct_user
            @jogtime = Jogtime.find(params[:id])
            redirect_to(root_url) unless (current_user.id == @jogtime.user_id) || current_user.admin?
        end

        # Confirms the correct user.
        def create_user
            @user = User.find(session[:user_id])
            redirect_to(root_url) unless current_user?(@user) || current_user.admin?
        end
end
