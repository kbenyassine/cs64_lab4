1. the disaggregate function in gneral is seperating a input array into to two smaller arrays where 
one array holds values that are less than or equal to the average value of the initial array and the other
array holds values larger than the average value of the initual array. dissagregate is then called twice where
the first mentioned array is used as an input array and then the second mentioned array is used as an input. This continues
until there is one element left in the array or that the depth is equal zero, which is decremented every function call. 
At the start of each function call, the values of the input array is printed out. At the start and end of the function,
we allocate and deallocate our values on the stack so we keep them saved and that they are not overwritten.

2. The space used in the stack will not change even if you change the array length, array values, or depth values. 
It is because the space need to allocate for any value would be 1 word, or 4 bytes, or 32 bits. Nothing will go beyond that.