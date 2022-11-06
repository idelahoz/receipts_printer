require './sale_processor.rb'

directory_input = ARGV[0] || "fixtures"

files = Dir.entries(directory_input).select { |f| File.file? File.join(directory_input, f) }
files.each_with_index do |file, i|
  items = File.open(File.join("fixtures", file)).to_a
  puts "receipt for #{file}"
  puts SaleProcessor.new(items).print_receipt
  puts "=" * 20
end