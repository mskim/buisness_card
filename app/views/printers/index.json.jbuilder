json.array!(@printers) do |printer|
  json.extract! printer, :id, :name, :contact, :email, :cell, :agent_id
  json.url printer_url(printer, format: :json)
end
