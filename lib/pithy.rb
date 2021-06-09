def tokenize(string)
  # TODO: test this with various tokenizing methods to see what gets the smallest size
  string.split(' ')
end

def score(token)
  # TODO: test this with a few scoring methods to see what gets the smallest size
  token.length
end

def token_map_sequence
  # TODO: actually generate this, to N values (where N = keyfile line count)
  %w(a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac)
end

def minify(token, translation_key)
  translation_key[token]
end

def bigify(token, translation_key)
  translation_key[token]
end