
class Solution:
  def countVowels(self, s: str) -> int:
    vowels = ["a","e", "i", "o", "u"]
    count = 0
    for char in s:
      if char in vowels:
        count += 1
    return count
