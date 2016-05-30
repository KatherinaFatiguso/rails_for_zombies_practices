json.array!(@brains) do |brain|
  json.extract! brain, :id, :zombie_id, :status, :flavour
  json.url brain_url(brain, format: :json)
end
