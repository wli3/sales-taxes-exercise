require_relative 'item.rb'

class LineParser
  def parse(line)
    if line.length > 80
      fail 'The line is too long. Probably is not the correct file.'
    end
    item = Item.new(parse_import_condition(line),
                    parse_name(line),
                    parse_price(line))
    { item => parse_quantity(line) }
  end

  private

  def parse_price(line)
    number = line[/\d+\.?\d+$/]
    fail "No price in this line #{line}" if number.nil?
    fail 'Wrong price formate' if number[/\.\d+$/].length > 3
    number.to_f / parse_quantity(line)
  end

  def parse_quantity(line)
    quantity = line[/^\d+/]
    fail "no quality in this line #{line}" if quantity.nil?
    quantity.to_i
  end

  def parse_import_condition(line)
    / imported / === line
  end

  def parse_name(line)
    name = line.sub(/imported /, '')
           .sub(/ at \d+\.?\d+$/, '')
           .sub(/^\d+( imported)? /, '')
           .strip
    fail "No name find in these line #{line}" unless name
    name
  end
end
