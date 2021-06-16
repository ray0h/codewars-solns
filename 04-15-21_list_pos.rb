# https://www.codewars.com/kata/582c1092306063791c000c00/train/ruby

# Description:

# There is a infinite string. You can imagine it's a combination of numbers from 1 to n, like this:

# "123456789101112131415....n-2n-1n"
# Please note: the length of the string is infinite. It depends on how long you need it(I can't offer it as a argument, it only exists in your imagination) ;-)

# Your task is complete function findPosition that accept a digital string num. Returns the position(index) of the digital string(the first appearance).

# For example:

# findPosition("456") == 3
# because "123456789101112131415".indexOf("456") = 3
#             ^^^
# Is it simple? No, It is more difficult than you think ;-)

# findPosition("454") = ?
# Oh, no! There is no "454" in "123456789101112131415",
# so we should return -1?
# No, I said, this is a string of infinite length.
# We need to increase the length of the string to find "454"

# findPosition("454") == 79
# because "123456789101112131415...44454647".indexOf("454")=79
#                                    ^^^
# The length of argument num is 2 to 15. So now there are two ways: one is to create a huge own string to find the index position; Or thinking about an algorithm to calculate the index position.

# Which way would you choose? ;-)

# Some examples:

#  findPosition("456") == 3
#  ("...3456...")
#        ^^^
#  findPosition("454") == 79
#  ("...444546...")
#         ^^^
#  findPosition("455") == 98
#  ("...545556...")
#        ^^^
#  findPosition("910") == 8
#  ("...7891011...")
#         ^^^
#  findPosition("9100") == 188
#  ("...9899100101...")
#          ^^^^
#  findPosition("99100") == 187
#  ("...9899100101...")
#         ^^^^^
#  findPosition("00101") == 190
#  ("...99100101...")
#          ^^^^^
#  findPosition("001") == 190
#  ("...9899100101...")
#            ^^^
#  findPosition("123456789") == 0
#  findPosition("1234567891") == 0
#  findPosition("123456798") == 1000000071
# A bit difficulty, A bit of fun, happy coding ;-)

class ListIndex

  def no_index(str)
    return 0 if str[0].to_i <= 0

    n = str.length
    val = str.to_i
    ind = 0
    (1..n-1).each {|x| ind += x * 9 * 10**(x-1) }
    ind += (val - 10**(n-1)) * n
  end

  def in_range?(substr, str)
    return false if substr.start_with?('0')

    if substr.to_i == 1
      l_range = ''
    else
      low_val = substr.to_i - 1
      l_range = low_val.to_s
      l_range = (low_val-=1).to_s + l_range until l_range.length >= str.length || low_val < 1
    end

    high_val = substr.to_i + 1
    h_range = high_val.to_s
    h_range += (high_val+=1).to_s until h_range.length >= str.length
    
    (l_range + substr + h_range).include?(str)
  end

  def eval_overlap(str1, str2)
    # handle '9+' wrapping edge case
    return (str2.to_i - 1).to_s + str1 if str1.chars.all?('9')

    (0..str2.length-1).each do |n|
      sub = str2.slice(n, str2.length)
      return str2.slice(0, n) + str1 if str1.start_with?(sub) 
    end
    str2 + str1
  end

  def eval_wrap(str)
    num = str.start_with?('0') ? ('1'+str).to_i : str.to_i

    (1..str.length-1).each do |n|
      wrapped = str.slice(n, str.length) + str.slice(0, n) 
      num = wrapped.to_i if in_range?(wrapped, str) && wrapped.to_i <= num 
      # p "1: #{wrapped}"
      wrapped2 = eval_overlap( str.slice(0, n), str.slice(n, str.length) )
      num = wrapped2.to_i if in_range?(wrapped2, str) && wrapped2.to_i < num 
      # p "2: #{wrapped2}"
    end
    num
  end

  def eval_zeros(str)
    num = str.start_with?('0') ? ('1'+str).to_i : str.to_i
    return num if str.chars.all?('0') || !str.chars.include?('9')

    (0..str.length-2).each do |n|
      if str[n] == '9'
        zeros = str.slice(n+1, str.length) 
        while zeros.length != str.length
          zeros += '0'
          num = zeros.to_i if in_range?(zeros, str) && zeros.to_i <= num
        end
      end
    end
    num - 1
  end

  def iterate_digits(str)
    num = str.start_with?('0') ? ('1'+str).to_i : str.to_i
    (1..str.length).each {|len|
      (0..str.length-1).each {|l| 
        next if l + len > str.length

        val = str.slice(l, len)
        next unless in_range?(val, str) && val.to_i < num && !val.start_with?('0')

        num = l.zero? ? val.to_i : val.to_i - 1
      }
    }
    num
  end

  def calc_offset(num, str)
    if num.to_s == str
      offset = 0
    elsif num.to_s.length > str.length
      offset = num.to_s.length - str.length
    else
      start = str.slice(0, num.to_s.length)
      start = start.chop until num.to_s.end_with?(start) && str[start.length].start_with?((num+1).to_s[0])
      offset = num.to_s.length - start.length
    end
    offset
  end

  def find_num(str)
    num = [eval_wrap(str), eval_zeros(str), iterate_digits(str)].min
    offset = calc_offset(num, str)
    # p "#{str}, #{num}, #{offset}, #{no_index(num.to_s)+offset}"
    no_index(num.to_s) + offset
  end

end

calc = ListIndex.new
# tests under list_index_spec.rb

strs = ['456', '454', '455', '910', '9100', '99100', '00101', '001', '00', '123456789', '1234567891', '123456798', '10', '53635', '040', '11', '99', '667', '0404', '949225100', '58257860625', '3999589058124', '555899959741198', '01', '091', '0910', '0991', '09910', '09991']
# strs.each{ |s| find_num(s) }


calc.find_num('55441749109645')
# p calc.no_index('1096455441749')
# p calc.eval_overlap('55441749','109645')
