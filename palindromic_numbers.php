<?php

/*

Palindromic Numbers
A palindromic number is a number that reads the same forwards as it does backwards. 123321 is a palindromic number where as 321321 is not. Negative numbers may be considered palindromic or not; it's up to you until someone proves otherwise.

Your mission, should you choose to accept it, is to create a program to return whether a number is a palindromic number or not. To make things slightly more interesting you may not use a string or array in your solution. Thus doing something like "123.toString()" is not allowed.

*/


function isPalindromic($number) {
	$isPalindrome = true;
	$length = ceil(log10($number)); // number of digits
	for ($i=1; $i<=($length/2); $i++) { // run through digits comparing them (stop at the midpoint)
		$start = floor($number % (pow(10, ($length-$i+1))) / pow(10, $length-$i));
		$end = floor($number % (pow(10, ($i))) / pow(10, $i-1));
		if ($start != $end) {
			$isPalindrome = false;
		}
	}
	return $isPalindrome;
}

print (isPalindromic($argv[1])) ? "is" : "is not";
print " a palindrome\n";
