require "json"
require 'date'
require_relative "communication"
require_relative "practitioner"
# votre code
@practitioners = []
@communications = []
totals = []

def subTotal(communication)
  @doctor = @practitioners.each {|p| p if communication.id == p.id}.first
  sum = 0.1
  sum += 0.18 if communication.color == true
  pages = (communication.pages_number-1)*0.07
  sum += pages
  sum += 0.6 if @doctor.express_delivery == true
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

def exportJSON(filepath, object)
  File.open(filepath, 'wb') do |file|
  file.write(JSON.generate(object))
end
end

importJSON('level1/data.json')
@communications.each do |com|
  date = Date.strptime(com.sent_at, '%Y-%m-%d').to_s
    if totals.select{|x| x[:sent_on] == date} == []
      totals << {
        "sent_on": date,
        "total": subTotal(com).round(2)
      }
  else
    ary = totals.find{|x| x[:sent_on] == date}
    ary[:total] += subTotal(com).round(2)
  end
end
exportJSON('level1/output_2.json', totals)
