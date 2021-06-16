# https://www.codewars.com/kata/54eb33e5bc1a25440d000891/train/ruby

# My little sister came back home from school with the following task: given a squared sheet of paper she has to cut it in pieces which, when assembled, give squares the sides of which form an increasing sequence of numbers. At the beginning it was lot of fun but little by little we were tired of seeing the pile of torn paper. So we decided to write a program that could help us and protects trees.

# Task

# Given a positive integral number n, return a strictly increasing sequence (list/array/string depending on the language) of numbers, so that the sum of the squares is equal to n².

# If there are multiple solutions (and there will be), return as far as possible the result with the largest possible values:

# Examples

# decompose(11) must return [1,2,4,10]. Note that there are actually two ways to decompose 11², 11² = 121 = 1 + 4 + 16 + 100 = 1² + 2² + 4² + 10² but don't return [2,6,9], since 9 is smaller than 10.

# For decompose(50) don't return [1, 1, 4, 9, 49] but [1, 3, 5, 8, 49] since [1, 1, 4, 9, 49] doesn't form a strictly increasing sequence.

# Note

# Neither [n] nor [1,1,1,…,1] are valid solutions. If no valid solution exists, return nil, null, Nothing, None (depending on the language) or "[]" (C) ,{} (C++), [] (Swift, Go).

# The function "decompose" will take a positive integer n and return the decomposition of N = n² as:

# [x1 ... xk] or
# "x1 ... xk" or
# Just [x1 ... xk] or
# Some [x1 ... xk] or
# {x1 ... xk} or
# "[x1,x2, ... ,xk]"
# depending on the language (see "Sample tests")

# Note for Bash

# decompose 50 returns "1,3,5,8,49"
# decompose 4  returns "Nothing"

# Hint
# Very often xk will be n-1.


require 'benchmark'

def decompose(n)
    def nested(arr, value, poss=[], coll=[], index=0)
        if coll.length > 0 
            # solution is found
            return coll
        elsif poss.reduce(&:+) == value 
            coll.push(poss.map{|x| x}.sort)
        else
            for i in (arr.length-1).downto(0)
                break if coll.length > 0
                poss[index] = arr[i]
        
                remainder = value - poss.reduce(&:+)
                # get rid of current index if solution not found at end of iteration
                poss.pop if i.zero? && !remainder.zero?
                next if i.zero? && !remainder.zero?
                
                filtered = arr.select {|x| x <= remainder && x != arr[i]}
                next if filtered.empty? && remainder>0
                
                next if !filtered.empty? && filtered.reduce(&:+) < remainder

                nested(filtered, value, poss, coll, index+1)
            end
        end
        coll.length.zero? ? nil : coll
    end

    sqrArr = (1..n-1).to_a.map{ |x| x**2 }
    coll = nested(sqrArr, n**2)
    coll.nil? ? nil : coll[0].map { |no| (no**0.5).to_i }
end

time = Benchmark.measure {
    p decompose(50)
    p decompose(44)
    p decompose(625)
    p decompose(5)
    p decompose(7100)
    p decompose(123456)
    p decompose(1234567)
    p decompose(7654321)
    p decompose(7654322)
    p decompose(76)
    p decompose(7)
    p decompose(9927447)
    p decompose(12)
} 

puts time