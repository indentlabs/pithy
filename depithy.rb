#!/usr/bin/ruby
# Usage: ./depithy -k king.pith minified-file.txt -o bigified-file.txt

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] <filename.txt>"

  opts.on("-k", "--key key.pith", "Specify a pithy keyfile") do |filename|
    options[:key] = filename
  end
  opts.on("-o", "--out bigified.txt", "Specify where to save the bigified file") do |filename|
    options[:out] = filename
  end
end.parse!

def exit_with_usage_info
  puts "Usage:\n\t#{$0} <filename> -k <key.pith>"
  puts
  exit(1)
end

filename = ARGV.shift or begin
  puts "Error: No filename specified."
  exit_with_usage_info
end
unless options[:key]
  puts "Error: No pithy key specified."
  exit_with_usage_info
end

def tokenize(string)
  # TODO: test this with various tokenizing methods to see what gets the smallest size
  string.split(' ')
end

def bigify(token)
  $translation_key[token]
end

def token_map_sequence
  # TODO: actually generate this, to N values (where N = keyfile line count)
  %w(a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac)
end

# Read the key and build a translation key from it
pith_key = []
File.foreach(options[:key]) do |line|
  pith_key.push(line.chop)
end
$translation_key = Hash[token_map_sequence.first(pith_key.length).zip(pith_key)]

# Open the output file
output_filename = options[:out] || "bigified-#{filename}"
File.open(output_filename, 'w') do |output|
  # Transform tokens line-by-line in the original file, spit them into output file
  File.foreach(filename) do |line|
    tokenize(line).each do |token|
      output.write("#{bigify(token)} ")
    end
  end
end

puts "File #{filename} is no longer pithy! Bigified version saved to #{output_filename}"

original_size = File.size(filename)
output_size   = File.size(output_filename)
delta_size    = output_size - original_size
puts "Original filesize: #{original_size}"
puts "New filesize:      #{output_size}"
puts "Increased by       #{delta_size} (~#{(delta_size.to_f / original_size * 100).to_i}% increase)"
puts
