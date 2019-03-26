require "json"
require 'date'
require 'bigdecimal'
require_relative "communication"
require_relative "practitioner"
# votre code
@practitioners = []
@communications = []
@totals = []

def subTotal(communication)
  @doctor = @practitioners.each {|p| p if communication.id == p.id}.first
  sum = 0.10 + BigDecimal.new("0")
  sum += 0.18 if communication.color == true
  pages_printed = communication.pages_number-1
  pages_paid = pages_printed*0.07
  sum += pages_paid
  sum += 0.60 if @doctor.express_delivery == true
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

def exportJSON(filepath, object)
  File.open(filepath, 'wb') do |file|
    file.write(JSON.generate(object))
  end
end

def getTotals(communications)
  communications.each do |com|
    date = Date.strptime(com.sent_at, '%Y-%m-%d').to_s
    @totals
      if @totals.select{|x| x[:sent_on] == date} == []
        @totals << {
          "sent_on": date,
          "total": subTotal(com)
        }
    else
      ary = @totals.find{|x| x[:sent_on] == date}
      ary[:total] += subTotal(com)
    end
  end
  @totals
end

importJSON('data.json')
getTotals(@communications)
exportJSON('output_2.json', @totals)
