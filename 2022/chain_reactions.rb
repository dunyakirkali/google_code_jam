input_data = File.readlines("chain_reactions_sample_ts1_input.txt")
# input_data = ARGF.readlines

def calc(fun_factors, pointers, start, visited = [])
  funs = []
  touch = []
  loop do
    touch << start
    funs << fun_factors[start] unless visited.member?(start)
    break if pointers[start] == 0
    start = pointers[start] - 1
  end
  [funs.max, touch]
end

def paths(fun_factors, pointers)
  initiators(pointers)
  .map { |i|
    calc(fun_factors, pointers, i)
  }
  .sort_by { |h| [h[1].length, h[0]] }
  .map { |h| h[1].first }
end

def initiators(pointers)
  (Array(1..pointers.length) - pointers.uniq)
  .map { |i| i - 1 }
end

input_data
  .drop(1)
  .each_slice(3)
  .map
  .with_index { |item, index|
    fun_factors = item[1].split(" ").map(&:to_i)
    pointers = item[2].split(" ").map(&:to_i)
    puts paths(fun_factors, pointers)
    res = paths(fun_factors, pointers)
      .permutation
      .to_a
      .map { |sol|
        sol.reduce({sum: 0, visited: []}) { |hash, start|
          result = calc(fun_factors, pointers, start, hash[:visited])
          {
            sum: hash[:sum] + result[0],
            visited: hash[:visited] + result[1]
          }
        }
      }
      .map { |item| item[:sum] }
      .max

    puts "Case ##{index + 1}: #{res}"
  }

