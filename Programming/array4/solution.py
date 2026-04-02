
class Solution:
  def firstDuplicate(self, nums: list[int]) -> int:
    noDup = set();
    for num in nums:
      prevLen = len(noDup)
      noDup.add(num)
      if len(noDup) == prevLen:
        return num
    return -1
