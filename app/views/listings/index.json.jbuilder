json.array!(@listings) do |listing|
  json.extract! listing, :id, :title, :description, :home_type, :room_type, :city, :user_id
  json.url listing_url(listing, format: :json)
end
