class Practitioner
  def initialize(attributes = {})
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @express_delivery = attributes[:express_delivery]
  end
end
