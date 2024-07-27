class Term
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :word, :string
  attribute :definition, :string
  attribute :example, :string
  attribute :author, :string

  def self.from_api(word)
    definitions = UrbanDictionaryService.define(word)
    first_definition = definitions.first
    if first_definition
      new(
        word: first_definition['word'],
        definition: first_definition['definition'],
        example: first_definition['example'],
        author: first_definition['author']
      )
    else
      new(word: word, definition: "No definition found.")
    end
  end

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
