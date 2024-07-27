class TermFetcher
  def self.fetch(word)
    new(word).fetch
  end

  def initialize(word)
    @word = word
  end

  def fetch
    definitions = UrbanDictionaryService.define(@word)
    first_definition = definitions.first

    Term.new(
      word: first_definition['word'],
      definition: first_definition['definition'],
      example: first_definition['example'],
      author: first_definition['author']
    )
  end
end
