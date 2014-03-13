<?php

/*
  2014/03/06

Vigenère cipher
The Vigenère cipher made its rounds in the mid-1550s up until the end of the American Civil War. It was very easy for soldiers to encode messages and pass them around to all the allied camps.

The cipher requires a key and a message. It works like this:

Key:
REDDIT
Message:
TODAYISMYBIRTHDAY
REDDITREDDITREDDI
TODAYISMYBIRTHDAY
--------------------------
KSGDGBJQBEQKKLGDG

Using a 0 based alphabet (A=0), R is the 17th letter of the alphabet and T is the 19th letter of the alphabet. (17 + 19) mod 25 = 11 which is where K resides in the alphabet. Repeat for each key/message letter combination until done.

Today's problem of the day is two part. The first part is to implement a Vigenère cipher in the programming language of your choice. Feel free to post solutions or links to solutions in the comments.

The second part is to try and implement something to crack the message below (the key is 5 or less characters).

ZEJFOKHTMSRMELCPODWHCGAW

Good luck!
*/

// encode a letter with a given key
function encodeLetter($message, $key) {
  $mValue = ord(strtoupper($message)) - 65;
  $kValue = ord(strtoupper($key)) - 65;
  $resultValue = ($mValue + $kValue) % 26;
  return chr($resultValue + 65);
}

// main body
$key = 'reddit';
$message = 'today is my birthday';

$messageLength = strlen($message);
$paddedKey = str_pad($key, $messageLength, $key);

$encodedMessage = array();
$messageArray = str_split($message);
$keyArray = str_split($paddedKey);
for ($i = 0; $i < $messageLength; $i++) {
  $encodedMessage[] = encodeLetter($messageArray[$i], $keyArray[$i]);
}

echo implode('', $encodedMessage) . "\n";

