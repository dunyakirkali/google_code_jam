input_data = File.readlines("3d_printing_sample_ts1_input.txt")
# input_data = ARGF.readlines

max_int = 9999999999
limit = 1000000

input_data
  .drop(1)
  .map { |line|
    line
    .split(" ")
    .map(&:to_i)
  }
  .each_slice(3)
  .to_a
  .map { |printer|
    printer
    .inject([max_int, max_int, max_int, max_int]) { |products, set|
      [
        [products[0], set[0]].min,
        [products[1], set[1]].min,
        [products[2], set[2]].min,
        [products[3], set[3]].min,
      ]
    }
  }
  .each
  .with_index { |calcs, index|
    print("Case ##{index + 1}: ")
    sum = calcs.inject(0, :+)
    if sum >= limit
      while sum > limit
        max_index = calcs.index(calcs.max)
        calcs[max_index] -= 1
        sum -= 1
      end
      print calcs.join(" ")
    else
      print "IMPOSSIBLE"
    end
    puts ""
  }
