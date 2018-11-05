module SessionsHelper

  # Enregistrements dans l'utilisateur donné
  def log_in(user)
    session[:user_id] = user.id
  end

  #  Se souvient d'un utilisateur dans une session persistante.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Renvoie l'utilisateur connecté actuel (le cas échéant).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Retourne true si l'utilisateur est connecté, sinon false.
  def logged_in?
    !current_user.nil?
  end

  # Oublie une session persistante
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Déconnecte l'utilisateur courant
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
