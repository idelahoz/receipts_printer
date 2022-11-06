require './sale_processor.rb'

files = Dir.entries("fixtures").select { |f| File.file? File.join("fixtures", f) }
files.each_with_index do |file, i|
  items = File.open(File.join("fixtures", file)).to_a
  puts "receipt for #{file}"
  puts SaleProcessor.new(items).print_receipt
  puts "=" * 20
end