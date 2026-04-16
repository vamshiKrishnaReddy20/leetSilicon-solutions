class Solution:
  def pairSumExists(self, nums: list[int], target: int) -> bool:
    
    for num in nums:
      for _, num2 in enumerate(nums, 1):
        if num + num2 == target:
          return True
    return False
