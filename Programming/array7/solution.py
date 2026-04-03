
class Solution:
  def majorityElement(self, nums: list[int]) -> int:
    Majority = None
    count = 0

    for num in nums:
        if count == 0:
            Majority = num
        count += (1 if num == Majority else -1)

    return Majority
