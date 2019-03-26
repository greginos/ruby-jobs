json.array! @communications do |communication|
  json.extract! communication, :practitioner_id, :sent_at
end
