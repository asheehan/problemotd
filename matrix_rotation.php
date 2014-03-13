<?php

/*
	2014/03/07

Matrix Rotation
The bank manager at my local bank recently gave me the algorithm to access the bank's vault. I thought I'd pass on the algorithm to you all for "safe keeping". Basically the vault has a USB port which you'll need to plug in to. Once plugged in the vault will send you an NxN matrix such as the one below.

Monday-Friday the key to the vault is to rotate the matrix 90 degrees clockwise. On Saturday and Sunday you have to rotate the matrix 90 degrees counter-clockwise. My dog accidentally got locked in the vault and the bank manager is no where to be found. Can someone help me write a program to get him out?

matrix=[[1,2,3,4,5],
        [6,7,8,9,10],
        [11,12,13,14,15],
        [16,17,18,19,20],
        [21,22,23,24,25]]

#Rotated 90 degrees clockwise
matrix=[[21, 16, 11, 6, 1], 
        [22, 17, 12, 7, 2],
        [23, 18, 13, 8, 3],
        [24, 19, 14, 9, 4],
        [25, 20, 15, 10, 5]]
Bonus points for fewer characters of code.
*/

// explode out the matrix in an easy-to-read format
function explodeMatrix($matrix) {
	$explodedMatrix = '';
	foreach ($matrix as $row) {
		$explodedMatrix .= "\n[[" . implode(',', $row) . "]";
	}
	return($explodedMatrix."]\n");
}

// rotate the matrix either left or right
function rotateMatrix(&$matrix, $direction) {
	// calculate the size of our matrix and initialize it
	$height = count($matrix);
	$width = ($height) ? count($matrix[0]) : 0;
	$rotatedMatrix = array();
	// init our matrix (make each row an array) (number of rows is the width, because of rotation)
	for ($i = 0; $i < $width; $i++) { 
		$rotatedMatrix[$i] = array_fill(0, $height, 0);
	}

	// populate the matrix
	for ($i = 0; $i < $height; $i++) { // the rows
		for ($k = 0; $k < $width; $k++) { // the columns
			// correct for right turn
			$newX = ($direction == 'right') ? $height - $i - 1 : $i;
			$newY = ($direction == 'right') ? $k : $width - $k - 1;
			$rotatedMatrix[$newY][$newX] = $matrix[$i][$k];
		}
	}
	$matrix = $rotatedMatrix;
}

$matrix = array(
			array(1,2,3,4,5),
        	array(6,7,8,9,10),
        	array(11,12,13,14,15),
        	array(16,17,18,19,20),
        	array(21,22,23,24,25)
        );

$direction = $argv[1]; // get user entered direction (accepted values 'right' and 'left'
if (!$direction || !($direction == 'left' || $direction == 'right')) {
	echo "please enter a direction (either 'left' or 'right')!\n";
	exit;
}
rotateMatrix($matrix, $direction);
print explodeMatrix($matrix);
