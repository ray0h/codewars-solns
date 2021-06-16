# https://www.codewars.com/kata/55b7bb74a0256d4467000070/train/ruby
# cheat article... https://medium.com/@meschreiber3/finding-the-number-of-reduced-fractions-with-denominator-d-d49f0f06c10c

# If n is the numerator and d the denominator of a fraction, that fraction is defined a (reduced) proper fraction if and only if GCD(n,d)==1.

# For example 5/16 is a proper fraction, while 6/16 is not, as both 6 and 16 are divisible by 2, thus the fraction can be reduced to 3/8.

# Now, if you consider a given number d, how many proper fractions can be built using d as a denominator?

# For example, let's assume that d is 15: you can build a total of 8 different proper fractions between 0 and 1 with it: 1/15, 2/15, 4/15, 7/15, 8/15, 11/15, 13/15 and 14/15.

# You are to build a function that computes how many proper fractions you can build with a given denominator:

# proper_fractions(1)==0
# proper_fractions(2)==1
# proper_fractions(5)==4
# proper_fractions(15)==8
# proper_fractions(25)==20
# Be ready to handle big numbers.

# Edit: to be extra precise, the term should be "reduced" fractions, thanks to girianshiido for pointing this out and sorry for the use of an improper word :)

require 'benchmark'

# v1
# def properFraction(n)
#   def isPrime(num, i=2)
#     return num == 2 ? true : false if (num <= 2)

#     return false if num % i == 0

#     return true if i * i > num

#     return isPrime(num, i+1)
#   end

#   def primeMultiples(n)
#     mult = [n]
#     (2..n/2).each { |no| mult.push(no) if n % no == 0 }
#     n > 2 ? mult.select{|no| isPrime(no)} : mult
#   end

#   mult = primeMultiples(n)
#   vals = (1..n).to_a
#   mult.each { |m| 
#     vals = vals.select{ |no| no % m != 0 } 
#   }
#   vals.length
# end

# v2
# def properFraction(n)
#   def isPrime(num, i = 2)
#     return num == 2 ? true : false if (num <= 2)

#     return false if num % i == 0

#     return true if i * i > num

#     return isPrime(num, i+1)
#   end

#   def primeMultiples(n)
#     mult = [n]
#     (2..(n/2)).each { |no| mult.push(no) if n % no == 0 } if n > 2
#     n > 2 ? mult.select{|no| isPrime(no)} : mult
#   end

#   def combos(arr, n, level=0, set=[], coms =[], index=0)
#     return nil if n <= 0 || n > arr.length + level
  
#     if level == n
#       coms.push(set.reduce(&:*))
#     else
#       arr.each {|x|
#         arr2 = arr - [x]
#         set[index] = x
#         combos(arr2, n, level+1, set, coms, index+1)
#       }
#     end

#     coms.uniq.sort
#   end

#   mult = primeMultiples(n)
#   (1..mult.length).each {|num|
#     arr = combos(mult, num)
#     val = num.odd? ? val - arr.map{|x| n/x}.reduce(&:+) : val + arr.map{|x| n/x}.reduce(&:+)
#   }
#   val.to_i
# end

# Final....
def properFraction(n)
  # Helper function to determine whether no is prime
  def isPrime(num, i = 2)
    return num == 2 ? true : false if (num <= 2)
    return false if num % i == 0
    return true if i * i > num
    return isPrime(num, i+1)
  end

  # find prime factors
  i = 2
  primes = []
  while i <= (Math.sqrt(n).ceil)
    if n % i == 0 
      primes.push(i) if isPrime(i)
      primes.push(n/i) if isPrime(n/i)
    end
    i += 1
  end

  # indirect confirmation that n is prime; 
  return n - 1 if primes.empty?

  val = n
  primes.uniq.each {|p| val = (val * (1 - 1/p.to_f)).to_i}
  val 
end

time = Benchmark.measure {
  p properFraction(1)
  p properFraction(2)
  p properFraction(5)
  p properFraction(15)
  p properFraction(25)
  p properFraction(6638772)
  p properFraction(9999999)

  p properFraction(9034)
  p properFraction(48931823)
}
puts time