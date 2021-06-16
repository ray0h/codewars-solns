# https://www.codewars.com/kata/58c5577d61aefcf3ff000081/train/ruby
# Create two functions to encode and then decode a string using the Rail Fence Cipher. This cipher is used to encode a string by placing each character successively in a diagonal along a set of "rails". First start off moving diagonally and down. When you reach the bottom, reverse direction and move diagonally and up until you reach the top rail. Continue until you reach the end of the string. Each "rail" is then read left to right to derive the encoded string.

# For example, the string "WEAREDISCOVEREDFLEEATONCE" could be represented in a three rail system as follows:

# W       E       C       R       L       T       E
#   E   R   D   S   O   E   E   F   E   A   O   C  
#     A       I       V       D       E       N    
# The encoded string would be:

# WECRLTEERDSOEEFEAOCAIVDEN
# Write a function/method that takes 2 arguments, a string and the number of rails, and returns the ENCODED string.

# Write a second function/method that takes 2 arguments, an encoded string and the number of rails, and returns the DECODED string.

# For both encoding and decoding, assume number of rails >= 2 and that passing an empty string will return an empty string.

# Note that the example above excludes the punctuation and spaces just for simplicity. There are, however, tests that include punctuation. Don't filter out punctuation as they are a part of the string.


def encodeRailFenceCipher(str, num_rails)
  return str if str.empty?
  letters = str.chars
  encoded = ''

  (0..num_rails-1).each {|rail|
    # gap is distance between letters in each rail
    # valley is gap in 'V' shape, mountain is gap in '^' shape
    valGap = ((num_rails-1) - rail) * 2
    mtnGap = rail * 2

    # go through each rail and insert letters into encoded array
    (rail..letters.length-1).step(mtnGap+valGap).each {|ind| 
      encoded += letters[ind] 
      encoded += letters[ind + valGap] unless valGap.zero? || mtnGap.zero? || ind + valGap > letters.length - 1
    }
  }
  encoded
end

def decodeRailFenceCipher(str, num_rails)
  return str if str.empty?
  letters = str.chars
  decoded = []

  pointer = 0
  (0..num_rails-1).each {|rail|
    valGap = ((num_rails-1) - rail) * 2
    mtnGap = rail * 2
    # go through each rail and insert letters into encoded array
    (rail..letters.length-1).step(mtnGap+valGap).each {|ind| 
      decoded[ind] = letters[pointer] 
      pointer += 1
      unless valGap.zero? || mtnGap.zero? || ind + valGap > letters.length - 1
        decoded[ind + valGap] = letters[pointer]
        pointer += 1
      end
    }
  }
  decoded.join
end

p encodeRailFenceCipher('', 3)
p encodeRailFenceCipher('WEAREDISCOVEREDFLEEATONCE', 3)
p decodeRailFenceCipher('WECRLTEERDSOEEFEAOCAIVDEN', 3)
p encodeRailFenceCipher('WEAREDISCOVEREDFLEEATONCE', 4)
p decodeRailFenceCipher('WIREEEDSEEEACAECVDLTNROFO', 4)
p encodeRailFenceCipher('WEAREDISCOVEREDFLEEATONCE', 9)
p decodeRailFenceCipher('WLEFEADEREAERTDEOIVNSOCCE', 9)