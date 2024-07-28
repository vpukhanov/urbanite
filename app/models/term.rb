class Term
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :word, :string
  attribute :definition, :string
  attribute :example, :string
  attribute :author, :string
  attribute :part_of_speech, :string

  def initialize(attributes = {})
    super
    convert_links!
  end

  private

  def convert_links!
    self.definition = convert_links(definition)
    self.example = convert_links(example)
  end

  def convert_links(text)
    text&.gsub(/\[([^\]]*)\]/, '<a href="/terms/\1">\1</a>')
  end
end
