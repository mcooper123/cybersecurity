#!/bin/bash
if (awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$5,$6} ' $2_Dealer_schedule  | grep -iq $1) ; then # checking to see if anything is found
if [ $3 -eq 3 ] ; then # Run this if Blackjack game is selected via arguement $3
echo "Blackjack dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$5,$6} ' $2_Dealer_schedule  | grep -i $1 #extract the data
else
if [ $3 -eq 5 ] ; then # Run this if Roulette game is selected via arguement $3
echo "Roulette dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$7,$8} ' $2_Dealer_schedule  | grep -i $1 #extract the data
else
if [ $3 -eq 7 ] ; then # Run this if Texas Hold'em game is selected via arguement $3
echo "Texas Hold 'em dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$9,$10} ' $2_Dealer_schedule  | grep -i $1 #extract the data
else
if [ $3 -eq 9 ] ; then # Run this if Texas Hold'em game is selected via arguement $3
echo "Blackjack dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$5,$6} ' $2_Dealer_schedule  | grep -i $1 #extract the data
echo " "
echo "Roulette dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$7,$8} ' $2_Dealer_schedule  | grep -i $1 #extract the data
echo " "
echo "Texas Hold 'em dealer" && awk -F'[:" "\t]' '{new_var=$1$4} {print new_var,$9,$10} ' $2_Dealer_schedule  | grep -i $1 #extract the data
else
clear #Clear screen of error message for custom error handling below
echo "You did not select the correct field to output the dealers first name for a valid game type." #Error message due to incorrect game type entered for argument $3 or ommmitted
echo "3 = Blackjack, 5 = Roulette, 7 = Texas Hold 'em and 9=all"
echo "correct syntax example - sh roulette_dealer_finder_by_time_and_game.sh 10PM 0310 7"
fi
fi
fi
fi
else
clear #Clear screen of error message for custom error handling below
echo "You have made an error or data doesn't exist for the time and date you are searching for,"
echo "make sure that you entered the arguements in the correct format." #Error message when no rows could be found to be output. Probably from incorrect time or date entered for arguments $1 and/or $2
echo "Time is entered by HHA/PM (05AM, 10PM etc). The date is mmdd (0310 for 10th March)" #provide valid date paramters
echo "Select which game you want to report on with 3 = Blackjack, 5 = Roulette, 7 = Texas Hold 'em and 9=all"
echo "correct syntax example - sh roulette_dealer_finder_by_time_and_game.sh 10PM 0310 7"
fi
# Script was written on the assumption that the data files were located in the same directory as the script.
