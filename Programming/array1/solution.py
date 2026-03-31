
class Solution:
  def maxMin(self, nums: list[int]) -> tuple[int, int]:
    maxi = nums[0]
    mini = nums[0]

    for num in nums :
      if num > maxi :
        maxi = num
      elif num < mini :
        mini = num
    return (maxi, mini)