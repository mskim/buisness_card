json.array!(@companies) do |company|
  json.extract! company, :id, :name, :contact, :email, :variables, :printer_id
  json.url company_url(company, format: :json)
end
