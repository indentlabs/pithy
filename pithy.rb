#!/usr/bin/ruby
# Usage: ./pithy -k king.pith stephen-king-collection.txt

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] <filename.txt>"

  opts.on("-k", "--key key.pith", "Specify a pithy keyfile") do |filename|
    options[:key] = filename
  end
  opts.on("-o", "--out minified.txt", "Specify where to save the minified file") do |filename|
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

def token_map_sequence
  # TODO: actually generate this, to N values (where N = keyfile line count)
  %w(a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac)
end

def tokenize(string)
  # TODO: test this with various tokenizing methods to see what gets the smallest size
  string.split(' ')
end

def minify(token)
  $translation_key[token]
end

# Read the key and build a translation key from it
pith_key = []
File.foreach(options[:key]) do |line|
  pith_key.push(line.chop)
end
$translation_key = Hash[pith_key.zip(token_map_sequence.first(pith_key.length))]

# Open the output file
output_filename = options[:out] || "minified-#{filename}"
File.open(output_filename, 'w') do |output|
  # Transform tokens line-by-line in the original file, spit them into output file
  File.foreach(filename) do |line|
    tokenize(line).each do |token|
      output.write("#{minify(token)} ")
    end
  end
end

puts "File #{filename} is now pithy! Minified version saved to #{output_filename}"

original_size = File.size(filename)
output_size   = File.size(output_filename)
delta_size    = -(output_size - original_size)
puts "Original filesize: #{original_size}"
puts "New filesize:      #{output_size}"
puts "Decreased by       #{delta_size} (~#{(delta_size.to_f / original_size * 100).to_i}% reduction)"
puts
puts "To depithify it, don't forget you will need #{options[:key]}!"
puts "$ ./depithy #{output_filename} -k #{options[:key]}"