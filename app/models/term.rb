class Term
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :word, :string
  attribute :definition, :string
  attribute :example, :string
  attribute :author, :string

  def self.from_api(word)
    api_response = {
      'word' => word,
      'definition' => "This is a [sample] definition for #{word}.",
      'example' => "Here's a [sample] example using #{word}.",
      'author' => 'API Author'
    }

    new(api_response)
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
