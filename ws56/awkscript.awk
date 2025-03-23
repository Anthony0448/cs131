BEGIN {FS=","} # Set the deilimiter
# Each unique tip amount is stored in an array. Passing column 14 is the location in the array like a dictionary to increment
# Notice this expression is not in the BEGIN or END area since this instruction is applied to each line	
{
	# Every single tip amount is counted, but we will only print the ones over ten dollars
	# We check the frequency for each tip
    tip_amounts[$14]++ 
}

END {
	# For every element in tip_amounts print if the tip amount is greater or equal to 10
	for (t in tip_amounts) {
		# Check if the tip value is greater or equal to 10 in order to print
		if (t >= 10) {
			# Print the value of the tip and the amount of times it appears
			# Remember the "index" for this array can be a number or a name/decimal can serve as the index like in this case
			print t, tip_amounts[t]
		}
		}
	}
