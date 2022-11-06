require 'yaml'

class Item
  def initialize(line)
    @line = line
  end

  def product
    @product ||= @line.split(" at ").first.split(" ", 2).last
  end

  def price
    @price ||= @line.split(" at ").last.to_f
  end

  def quantity
    @quantity ||= @line.split(" ").first.to_i
  end

  def total
    @total ||= quantity * price
  end

  def total_with_taxes
    @total_with_tax ||= (total + tax ).round(2)
  end

  def tax
    @tax ||= sales_tax + import_tax
  end

  private

  def import_tax
    @import_tax ||= imported? ? (total * 0.05).round(2) : 0.0
  end

  def exempt?
    exempt_products.any? { |p| product.include?(p) }
  end

  def sales_tax
    @sales_tax ||= exempt? ? 0.0 : (total * 0.10).round(2)
  end

  def imported?
    product.include?("imported")
  end

  def exempt_products
    products = YAML.load_file("./product_categories.yml").values.flatten
    products + products.map { |p| "#{p}s" }
  end
end