def tokenize(string)
  # TODO: test this with various tokenizing methods to see what gets the smallest size
  string.split(' ')
end

def score(token)
  # TODO: test this with a few scoring methods to see what gets the smallest size
  token.length
end

def token_map_sequence
  Enumerator.new do |sequence|
    state = ''

    loop do
      state = state.dup

      if state == ''
        sequence << 'a'
        state = 'a'
      end

      # Increment characters from the right-hand side first, carrying leftward
      # e.g. ax, ay, az, ba, bb, ...
      (state.length - 1).downto(0).each do |incrementing_position|
        val = state[incrementing_position]

        case val
        when 'z'
          state[incrementing_position] = 'A'
          break

        when 'Z'
          state[incrementing_position] = 'a'

          # Perform a "carry" operation to the left
          if incrementing_position.zero?
            # We're as far left as we can go, so we want to just prepend an 'a'
            state = 'a' + state
            break
          
          else
            # If there are letters to the left to increment, we want to let the loop keep going

          end

        else
          state[incrementing_position] = (val.ord + 1).chr
          break

        end
      end

      # yield a next value in the sequence with <<
      sequence << state
    end
  end
end

def minify(token, translation_key)
  translation_key[token]
end

def bigify(token, translation_key)
  translation_key[token]
end

def translate(token, translation_key)
  translation_key[token]
end
