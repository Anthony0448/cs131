#!/bin/bash

my_function() {
	arg1=$1
	arg2=$2

	echo "$arg1 and $arg2"
}

# The two arguments foo and bar are passed as positional parameters
# No need to instruct it in the function just write them out when calling the function
my_function foo bar
