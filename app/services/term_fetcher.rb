class TermFetcher
  def self.fetch(word)
    new(word).fetch
  end

  def initialize(word)
    @word = word
  end

  def fetch
    all_definitions = UrbanDictionaryService.define(@word)
    definition = all_definitions.first

    part_of_speech = PartOfSpeechClassifier.classify(definition["word"], definition["definition"])

    Term.new(
      word: definition["word"],
      definition: definition["definition"],
      example: definition["example"],
      author: definition["author"],
      part_of_speech: part_of_speech
    )
  end
end
