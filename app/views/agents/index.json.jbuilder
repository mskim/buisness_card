json.array!(@agents) do |agent|
  json.extract! agent, :id, :name, :email, :cell, :bank_info
  json.url agent_url(agent, format: :json)
end
