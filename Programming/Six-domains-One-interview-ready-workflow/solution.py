class Solution:
  def countTriplets(self, arr: list[int]) -> int:
    arr.sort()
    n = len(arr)
    ans = 0
    
    for i in range(n - 2):
      left = i + 1
      right = n - 1
      
      while left < right:
        total = arr[i] + arr[left] + arr[right]
        
        if total < 0:
          left += 1
        elif total > 0:
          right -= 1
        else:
          if arr[left] == arr[right]:
            count = right - left + 1
            ans += (count * (count - 1)) // 2
            break
              
          left_count = 1
          right_count = 1
          
          while left + 1 < right and arr[left] == arr[left + 1]:
            left += 1
            left_count += 1
              
          while right - 1 > left and arr[right] == arr[right - 1]:
            right -= 1
            right_count += 1
              
          ans += left_count * right_count
          left += 1
          right -= 1
              
    return ans