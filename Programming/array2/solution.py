
class Solution:
  def reverseArray(self, nums: list[int]) -> None:
    # nums.reverse() #simple way
    
    #using pointers
    leftPtr = 0
    rightPtr = len(nums) - 1

    while(leftPtr < rightPtr):
      #Swapping
      nums[leftPtr], nums[rightPtr] = nums[rightPtr], nums[leftPtr]
      
      leftPtr += 1
      rightPtr -= 1


