json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :zombie_id, :role_id
  json.url assignment_url(assignment, format: :json)
end
