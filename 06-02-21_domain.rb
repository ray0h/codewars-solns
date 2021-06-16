# https://www.codewars.com/kata/514a024011ea4fb54200004b/train/ruby

# Write a function that when given a URL as a string, parses out just the domain name and returns it as a string. For example:

# domain_name("http://github.com/carbonfive/raygun") == "github" 
# domain_name("http://www.zombie-bites.com") == "zombie-bites"
# domain_name("https://www.cnet.com") == "cnet"

# learnings:
# () capture group returned in match function
# (?:) non capture group
# (?!, ?=, ?<!, ?<= ) negative/positive look ahead, negative/positive look behind
# <name_your_own_capture groups>
# or can just use [1] number in match

def domain_name(url)
  regex = /(?:(http|https):\/\/)?(?:www\.)?(?<domain_name>.*?)\./
  return url.match(regex)[:domain_name]
  
  # original solution:
  # regex = /(?:(?:(?:http:\/\/)?(?:www\.)?)|(?:(?:https:\/\/)?(?:www\.)?))([\w-]+)\./
  # matches = regex.match(url)
  # return matches.to_a.last
end

puts domain_name('http://github.com/carbonfive/raygun')
puts domain_name('http://www.zombie-bites.com')
puts domain_name('https://www.cnet.com')
puts domain_name('http://google.co.jp')
puts domain_name('www.xakep.ru')


