def draw(rows, cols)
  (rows * 2 + 1).times do |row|
    (cols * 2 + 1).times do |col|
      case true
        when row == 0 && col == 0 || row == 0 && col == 1 || row == 1 && col == 0
          print "."
        when row.even? && col.even?
          print "+"
        when row.even? && col.odd?
          print "-"
        when row.odd? && col.even?
          print "|"
        else
         print "."
      end
    end
    puts ""
  end
end

##

input_data = ARGF.readlines

input_data.each.with_index { |line, index|
  if index != 0
    puts "Case ##{index}:"
    dimensions = line.split(" ").map { |num| num.to_i }
    draw(dimensions[0], dimensions[1])
  end
}