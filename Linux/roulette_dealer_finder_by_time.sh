#!/bin/bash
if (awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$7,$8} ' ./$2_Dealer_schedule  | grep -iq $1) ; then # checking to see if anything is found
awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$7,$8} ' ./$2_Dealer_schedule  | grep -i $1 # run the command if the above check returned a value of true
else
clear #Clear screen of error message for custom error handling below
echo "You have made an error or data doesn't exist for the time and date you are searching for,"
echo "Data currently only exists for the 10th, 12th and 15th of March - 0310, 0312 & 0315" #provide valid date paramters
echo "make sure that you entered the arguements in the correct format." # error statement when above check return a value of false
echo "Time is entered by HHA/PM (05AM, 10PM etc). The date is mmdd (0310 for 10th March)"
echo "Example sytax for this script is: sh roulette_dealer_finder_by_time.sh 10PM 0310"
fi
# Script was written on the assumption that the data files were located in the same directory as the script.
