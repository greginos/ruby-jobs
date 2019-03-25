class Communication
  attr_reader :sent_at, :color, :pages_number, :practitioner_id, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @practitioner_id = attributes[:practitioner_id]
    @pages_number = attributes[:pages_number]
    @color = attributes[:color]
    @sent_at = attributes[:sent_at]
  end

  def self.all
    @communications
  end
end
