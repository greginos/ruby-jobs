require "json"
require 'date'
require_relative "communication"
require_relative "practitioner"
# votre code
@practitioners = []
@communications = []
result = {}

def subTotal(communication)
  @doctor = @practitioners.each {|p| p if communication.id == p.id}.first
  sum = 0.1
  sum += 0.18 if communication.color == true
  sum += ((communication.pages_number-1)*0.07)
  sum += 0.6 if @doctor.express_delivery == true
  sum
end

def importJSON(filepath)
  serialized_data = File.read(filepath)
  new_data = JSON.parse(serialized_data)
  new_data["practitioners"].each do |practitioner|
    @practitioners << Practitioner.new(id: practitioner["id"],first_name: practitioner["first_name"], last_name: practitioner["last_name"],express_delivery: practitioner["express_delivery"] == true)
  end
  new_data["communications"].each do |communication|
    @communications << Communication.new(id: communication["id"], practitioner_id: communication["practitioner_id"], pages_number: communication["pages_number"], color: communication["color"] == true, sent_at: communication["sent_at"])
  end
end

importJSON('level1/data.json')
@communications.each do |com|
  date = Date.strptime(com.sent_at, '%Y-%m-%d').to_s
    if result[date].nil?
    result[date] = subTotal(com)
  else
    result[date] += subTotal(com)
  end
end

puts result
