# https://www.codewars.com/kata/5519a584a73e70fa570005f5/train/ruby

# Create an endless stream of prime numbers - a bit like IntStream.of(2, 3, 5, 7, 11, 13, 17), but infinite. The stream must be able to produce a million primes in a few seconds.

# If this is too easy, try Prime Streaming (NC-17).

# Note: the require keyword is disabled.

# tried to make a solution using basic primality tests (trial division) but this did not meet the time requirement.
# ! learned(again) that Array#select/#reject tend to be time consuming and it seems iterating through the array
# ! with simple arithimitic operations is more efficient....
# read up and researched other primality tests and eventually went with the sieve of eratosthenes based solution
# using an array of 0/1's and the corresponding indexes to determine primality.

# still unsure about how the class instance variable initiates and whether it counts against run time?

# 

require 'benchmark'
# submitted solution
# class Primes
#   def self.soe(n)
#     # initial array with all index values to be prime (1) (ignoring index 0,1)
#     arr = Array.new(n){1}
#     root = Math.sqrt(n).ceil
#     (2..root).each do |x|
#       next unless (arr[x]) == 1
      
#       (2..n).each do |y|
#         break if (x*y) > n
#         # ind is a composite, so set value to 0
#         arr[x*y] = 0
#       end
#     end
#     arr
#   end

#   # soe function doesn't get hoisted?!
#   @prime_list = soe(15_500_000)

#   def self.stream
#     Enumerator.new do |g|
#       ind = 2
#       loop do
#         ind += 1 until @prime_list[ind] == 1
#         g.yield(ind)
#         ind += 1
#       end
#     end
#   end
# end

#solution I liked (based on Aristat); other's used a 'half sieve' and also seemed compact/elegant.
class Primes
  LIMIT = 15_500_000
  @prime_list = [nil, nil, *2..LIMIT]
  root = Math.sqrt(LIMIT)
  (2..root).each do |x|
    (x**2..LIMIT).step(x){|y| @prime_list[y] = nil } if @prime_list[x]
  end
  @prime_list = @prime_list.compact
  p @prime_list.length

  def self.stream
    @prime_list.each
  end
end


prime = Primes.stream
time = Benchmark.measure {
  1000000.times do |x|
    prime.next
  end
  p prime.next
}

puts time