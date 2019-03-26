json.array! @communications do |communication|
  practitioner = Practitioner.find(communication.practitioner_id)
  json.extract! practitioner, :first_name, :last_name
  json.extract! communication, :sent_at
end
