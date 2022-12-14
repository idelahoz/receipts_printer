require './item.rb'

class SaleProcessor\
  def initialize(item_lines)
    @item_lines = item_lines
  end

  def print_receipt
    receipt = ""
    items.each do |item|
      receipt << "#{item.quantity} #{item.product}: #{sprintf('%.2f',item.total_with_taxes)}\n"
    end
    receipt << "Sales Taxes: #{sprintf('%.2f',sales_taxes)}\n"
    receipt << "Total: #{sprintf('%.2f',total)}"
  end

  private

  def items
    @items ||= @item_lines.map { |line| Item.new(line) }
  end

  def sales_taxes
    @sales_taxes ||= items.map(&:tax).reduce(:+).round(2)
  end

  def total
    @total ||= items.map(&:total_with_taxes).reduce(:+).round(2)
  end
end
