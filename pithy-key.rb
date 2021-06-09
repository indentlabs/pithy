#!/usr/bin/ruby
filename = ARGV.shift or begin
  puts "Error: No filename specified."
  puts "Usage:\n\t#{$0} <filename>"
  puts
  exit(1)
end
puts "filename : " + filename

def tokenize(string)
  # TODO: test this with various tokenizing methods to see what gets the smallest size
  string.split(' ')
end

def score(token)
  # TODO: test this with a few scoring methods to see what gets the smallest size
  token.length
end

def token_map_sequence
  %w(a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac)
end

# Generate the key!
token_scores = Hash.new(0)
File.foreach(filename).with_index do |line, line_num|
  puts "#{line_num}: #{line}"
  puts "Tokens: #{tokenize(line).inspect}"

  tokenize(line).each do |token|
    token_scores[token] += score(token)
  end
end

# Sort the token scores descending (highest score first)
sorted_tokens = token_scores.sort_by { |token, score| -score }

# Print the ordered tokens to the keyfile
File.open("#{filename}.pith", 'w') do |file|
  sorted_tokens.each do |token, score|
    file.puts("#{token} #{score}")
  end
end

puts "Key file made!"
puts sorted_tokens.inspect