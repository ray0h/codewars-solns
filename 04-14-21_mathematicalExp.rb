# https://www.codewars.com/kata/52a78825cdfc2cfc87000005/train/ruby

# Instructions

# Given a mathematical expression as a string you must return the result as a number.

# Numbers

# Number may be both whole numbers and/or decimal numbers. The same goes for the returned result.

# Operators

# You need to support the following mathematical operators:

# Multiplication *
# Division / (as floating point division)
# Addition +
# Subtraction -
# Operators are always evaluated from left-to-right, and * and / must be evaluated before + and -.

# Parentheses

# You need to support multiple levels of nested parentheses, ex. (2 / (2 + 3.33) * 4) - -6

# Whitespace

# There may or may not be whitespace between numbers and operators.

# An addition to this rule is that the minus sign (-) used for negating numbers and parentheses will never be separated by whitespace. I.e all of the following are valid expressions.

# 1-1    // 0
# 1 -1   // 0
# 1- 1   // 0
# 1 - 1  // 0
# 1- -1  // 2
# 1 - -1 // 2

# 6 + -(4)   // 2
# 6 + -( -4) // 10
# And the following are invalid expressions

# 1 - - 1    // Invalid
# 1- - 1     // Invalid
# 6 + - (4)  // Invalid
# 6 + -(- 4) // Invalid
# Validation

# You do not need to worry about validation - you will only receive valid mathematical expressions following the above rules.

require 'benchmark'

def operate(a, oper, b)
  return a + b if oper == '+'
  return a - b if oper == '-'
  return a * b if oper == '*'
  return a / b.to_f if oper == '/'

  'error'
end

def highest(arr)
  arr.include?('(')
end

def higher(arr)
  arr.include?('*') || arr.include?('/')
end

def splitStr(str)
  # eliminate spaces
  chrs = str.chars.select{ |x| x != ' ' }
  oper = ['+','-','*','/','(',')']
  express = []
  substr = ''
  
  chrs.each { |c| 
    # push substring if reached operator
    if !substr.empty? && oper.include?(c)
      express.push(substr) 
      substr = ''
    end
    
    # push operator unless last push was operator || beginning of str (indicates negative sign!)
    if oper.include?(c) 
      c == '-' && ( oper.include?(express.last) || express.empty?) ? substr += c : express.push(c) 
    end

    # add char to substr unless it's a space
    substr += c if c != ' ' && !oper.include?(c)
  }
  express.push(substr) unless substr.empty?
  express.map{|e| oper.include?(e) ? e : e.include?('.') ? e.to_f : e.to_i}
end

def replace(arr, operInd)
  value = operate(arr[operInd-1], arr[operInd], arr[operInd+1])
  arr.slice!(operInd-1, 3)
  arr.insert(operInd-1, value)
  arr
end

def rp(arr, lp_ind)
  stack = 1
  (lp_ind+1..arr.length-1).each{|x| 
    stack += 1 if arr[x] == '('
    stack -= 1 if arr[x] == ')'
    return x if stack.zero? && arr[x] == ')'
  } 
end

# def calc(str)
#   input = splitStr(str)
#   oper = ['+', '-', '*', '/', '(']
#   # evaluate parentheses expressions
#   while highest(input)
#     left = input.index('(')
#     right = rp(input, left)
#     ans = calc(input.slice(left+1, right-left-1).join)
#     if input[left-1] == '-' && (oper.include?(input[left-2]) || left < 2)
#       input.slice!(left,right-left+1)
#       input[left-1] = -ans
#     else 
#       input.slice!(left+1,right-left)
#       input[left] = ans
#     end
#   end

#   # evaluate higher order oper
#   while higher(input)
#     ind = [input.index('*'), input.index('/')].select{|x| !x.nil?}.min
#     input = replace(input, ind)
#   end

#   # work lower order oper left to right
#   input = replace(input, 1) until input.length === 1
#   input[0]
# end

def calc expression
  `ruby -e'p eval "#{expression.gsub(/(-?(?:\d*\.?)\d+)\b(?!\.)/,'\1.to_f()')}"'`.to_f
end

# p splitStr('5-3')
# p splitStr('-123')
# p splitStr('2 / (2 + 3) * 4.33 - -6')
# p splitStr('2 /2+3 * 4.75- -6')
# p splitStr('12* 123/-(-5 + 2)')
# p splitStr('((80 - (19)))')
# p splitStr('(1 - 2) + -(-(-(-4)))')

p calc('-123')
p calc('2 / (2 + 3) * 4.33 - -6')
p calc('2 /2+3 * 4.75- -6')
p calc('12* 123/-(-5 + 2)')
p calc('((80 - (19)))')
p calc('(1 - 2) + -(-(-(-4)))')
