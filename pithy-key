#!/usr/bin/ruby
# Usage:   ./pithy-key filename.txt
# Options: 
#         -o custom-dir/custom-name.pith     Saves the pithy key to a custom location

require_relative 'lib/pithy.rb'

require 'optparse'
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] <filename.txt>"

  opts.on("-o", "--out key.pith", "Specify where to save the pithy key") do |key|
    options[:key] = key
  end
end.parse!

filename = ARGV.shift or begin
  puts "Error: No filename specified."
  puts "Usage:\n\t#{$0} <filename>"
  puts
  exit(1)
end

# Generate the key!
token_scores = Hash.new(0)
File.foreach(filename) do |line|
  tokenize(line).reject { |token| token == '' || token == "\n" }.each do |token|
    token_scores[token] += score(token)
  end
end

# Sort the token scores descending (highest score first)
sorted_tokens = token_scores.sort_by { |token, score| -score }

# Print the ordered tokens to the keyfile
output_filename = options[:key] || "#{filename}.pith"
File.open(output_filename, 'w') do |file|
  sorted_tokens.each do |token, score|
    file.puts token
  end
end

puts "Key file saved to ./#{output_filename}"
puts "\tUnique words: #{token_scores.keys.count}"
puts "\tPithy score: #{token_scores.values.sum}"