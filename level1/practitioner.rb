class Practitioner
  attr_reader :id, :first_name, :last_name, :express_delivery

  def initialize(attributes = {})
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @express_delivery = attributes[:express_delivery]
  end

  def self.all
    @practitioners
  end

  def self.find(id)
    array = []
    p Practitioner.all
    @practitioners.each do |practitioner|
      array << practitioner if id == practitioner.id
    end
    array.first
  end
end
