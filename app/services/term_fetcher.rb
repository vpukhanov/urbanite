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

    if first_definition
      Term.new(
        word: first_definition['word'],
        definition: first_definition['definition'],
        example: first_definition['example'],
        author: first_definition['author']
      )
    else
      Term.new(word: @word, definition: "No definition found.")
    end
  end
end
