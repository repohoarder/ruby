module SessionsHelper
	# Logs in the given user.
	def log_in(user)
		session[:user_id] 	= user.id
	end
	def logged_in?
		!current_user.nil?
	end
end
