# input_data = File.readlines("d1000000_sample_ts1_input.txt")
input_data = ARGF.readlines

input_data
  .drop(1)
  .each_slice(2)
  .map
  .with_index { |item, index|
    dice_count = item[0].to_i
    die = item[1].split(" ").map(&:to_i).sort
    ans = 1
    die.each { |x|
      if x >= ans
        ans += 1
      end
    }
    ans -= 1

    puts "Case ##{index + 1}: #{ans}"
  }