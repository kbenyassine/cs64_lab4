1. the disaggregate function in gneral is seperating a input array into to two smaller arrays where 
one array holds values that are less than or equal to the average value of the initial array and the other
array holds values larger than the average value of the initual array. dissagregate is then called twice where
the first mentioned array is used as an input array and then the second mentioned array is used as an input. This continues
until there is one element left in the array or that the depth is equal zero, which is decremented every function call. 
At the start of each function call, the values of the input array is printed out. At the start and end of the function,
we allocate and deallocate our values on the stack so we keep them saved and that they are not overwritten.

2. The space used in the stack will change if you change the array length. If we increase the array length, that means we
need to store more values on the stack. Likewise, if we change the depth value, it will change the space we use in the stack.
If we increase the depth, we are increase the amount of times we call the function, which in turn increase the space we need to ensure
that we store the values we use. If the depth is n, we call the function a max of 2^n -1. Changing the actual array values does not 
change the space we use on the stack.