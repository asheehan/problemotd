<?php

/*
Smallest Integer
Congrats on making it to the final problem of the week! Today's problem is a bit tricky but will seem so obvious once you get it.

Write a function that when given 3 integers returns the smallest integer of the 3 without using any comparison operator (e.g.: >, <, ==) .

Something like "return min([1,2,3])" is cheating.
*/

function getSmallest ($a, $b, $c) {
  $myArray = array_fill(0,20,'');
  $myArray[$a] = $a;
  $myArray[$b] = $b;
  $myArray[$c] = $c;

  $k = 0;
  do {
    $k = array_shift($myArray);
  } while (!$k);
    
  return $k;
}

print getSmallest(7, 4, 13);

