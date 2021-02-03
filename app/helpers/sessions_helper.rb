module SessionsHelper
    
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        session[:order] = 1
    end
    
    # Returns the current logged-in user (if any).
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # Returns the user which is seen by the admin.
    def actual_user
        if (user_id = session[:actual_user])
            @actual_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @actual_user = user
            end
        end
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
        
    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Returns true if the given user is the current user.
    def current_user?(user)
        user && user == current_user
    end

    # Check if a user is admin.
    def admin_user
        current_user.admin?
    end
end
