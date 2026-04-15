class Solution:
  def missingNumber(self, nums: list[int]) -> int:
    mini = nums[0]
    index = 0
    for i, num in enumerate(nums, 1):
      if num < mini:
        mini = num
        index = i
    return index
