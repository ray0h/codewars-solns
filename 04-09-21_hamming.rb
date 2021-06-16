# https://www.codewars.com/kata/526d84b98f428f14a60008da/train/ruby


require 'benchmark'

def hamming(n)
  i = 0
  j = 0
  k = 0
  x2 = 2
  x3 = 3
  x5 = 5
  hams = [1]

  until hams.length == n
    val = [x2, x3, x5].min
    hams.push(val)

    x2 = 2 * hams[i += 1] while x2 == val
    x3 = 3 * hams[j += 1] while x3 == val
    x5 = 5 * hams[k += 1] while x5 == val
  end
  hams.last
end

time = Benchmark.measure {
  p hamming(5000)
}
puts time

time = Benchmark.measure {
  (1..5000).each { |x| hamming(x)}
}
puts time