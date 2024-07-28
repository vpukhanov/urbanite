require "engtagger"

class PartOfSpeechClassifier
  POS_TAG_HUMANIZED = {
    "nn" => "noun",
    "nns" => "noun",
    "nnp" => "noun",
    "nnps" => "noun",
    "vb" => "verb",
    "vbd" => "verb",
    "vbg" => "verb",
    "vbn" => "verb",
    "vbp" => "verb",
    "vbz" => "verb",
    "jj" => "adjective",
    "jjr" => "adjective",
    "jjs" => "adjective",
    "rb" => "adverb",
    "rbr" => "adverb",
    "rbs" => "adverb",
    "in" => "preposition",
    "cc" => "conjugation",
    "dt" => "determiner",
    "cd" => "number",
    "prp" => "pronoun",
    "prp$" => "pronoun",
    "rp" => "particle",
    "fw" => "misc",
    "sym" => "misc",
    "." => "punctuation"
  }

  def self.classify(word, definition)
    new.classify(word, definition)
  end

  def initialize
    @tagger = EngTagger.new
  end

  def classify(word, definition)
    return nil unless single_word?(word)

    # Tag the word alone first
    word_tag = @tagger.add_tags(word)
    word_pos = word_tag.scan(/<(\w+)>/).flatten.first

    # If the word alone doesn't give a clear POS, use the definition for context
    if word_pos == "nn" || word_pos == "nnp"
      text = "#{word} #{definition}"
      tagged = @tagger.add_tags(text)
      pos = tagged.scan(/<(\w+)>/).flatten.first
    else
      pos = word_pos
    end

    humanize_tag pos
  end

  private

  def single_word?(word)
    word.split.size == 1
  end

  def humanize_tag(tag)
    POS_TAG_HUMANIZED[tag] || "misc."
  end
end
