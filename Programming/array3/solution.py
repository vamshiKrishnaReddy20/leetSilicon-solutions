
class Solution:
  def findKthLargest(self, nums: list[int], k: int) -> int:
    sorted_nums = sorted(nums, reverse=True)
    return sorted_nums[k-1]
