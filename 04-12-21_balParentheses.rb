# https://www.codewars.com/kata/5426d7a2c2c7784365000783/train/ruby

# Write a function which makes a list of strings representing all of the ways you can balance n pairs of parentheses

# Examples

# balanced_parens(0) => [""]
# balanced_parens(1) => ["()"]
# balanced_parens(2) => ["()()","(())"]
# balanced_parens(3) => ["()()()","(())()","()(())","(()())","((()))"]

require 'benchmark'
# v1...
# def balanced?(str)
#   return false unless str.chars.all? { |l| ['(',')'].include?(l) }
#   stack = 0
#   str.chars.each {|x|
#     stack -= 1 if str[x] == ')'
#     stack += 1 if str[x] == '('
#     return false if stack.negative?
#   }
#   stack.zero? ? true : false
# end

# def unbalanced?(str)
#   return true unless str.chars.all? { |l| ['(',')'].include?(l) }
#   stack = 0
#   str.chars.each {|x|
#     stack -= 1 if str[x] == ')'
#     stack += 1 if str[x] == '('
#     return true if stack.negative?
#   }
#   stack.negative? ? true : false
# end

# def swap(str, a, b)
#   temp = str[b]
#   str[b] = str[a]
#   str[a] = temp
#   str
# end

# def permute(str, i, j, parr=[])
#   if i == j
#     copy = str.chars.join
#     parr.push(copy)
#   elsif unbalanced?(str)
#     return
#   else
#     (i..j).each {|x|
#       swap(str, i, x)
#       permute(str, i+1, j, parr)
#       swap(str, i, x)
#     }
#   end
#   parr
# end

# # timed out...
# def balanced_parens(n)
#   return [''] if n.zero?
#   str = (Array.new(n).fill('(') + Array.new(n).fill(')')).join
#   arr = permute(str, 0, str.length-1).uniq.select{|x| balanced?(x)}
#   p arr.length
#   arr
# end

# recursive function
def bp(n, count = 2*n, str='(', stack = 1, bpArr = [])
  return [''] if n.zero?

  if str.length == 2*n
    bpArr.push(str) if stack.zero?
  elsif str.count('(') > n || stack.negative?
    return
  else
    bp(n, count-1, str+='(', stack += 1, bpArr) unless stack.negative?
    str = str.chop
    stack -= 1
    bp(n, count-1, str+=')', stack -= 1, bpArr) unless stack.negative?
  end
  bpArr
end

# gets noticeably longer ~13, 14
(0..13).each {|x|
  time = Benchmark.measure {
    p bp(x).length
  }
  puts time
}
