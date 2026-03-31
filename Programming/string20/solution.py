
class Solution:
  def shortestPalindromeByAppending(self, s: str) -> str:
    
    if len(s) == 0:
      return ""
    elif s == s[::-1]: #if palin we return as it is
      return s
    else:
      return s + s[::-1][1:] # reversing and striping first letter