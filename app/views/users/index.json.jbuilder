json.array!(@users) do |user|
  json.extract! user, :id, :name, :stripe
  json.url user_url(user, format: :json)
end
