json.extract! user, :id, :first, :last, :email, :username, :password_digest, :active, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
