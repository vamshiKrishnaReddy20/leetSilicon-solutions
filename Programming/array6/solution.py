class Solution:
  def missingNumber(self, nums: list[int]) -> int:
    n = len(nums)
    total = n*(n+1) / 2
    Tsum = sum(nums)
    if total == Tsum:
      return 0
    else:
      return int(total - Tsum)
