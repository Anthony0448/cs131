{
	print $1
	if (index($7, "bash"))
		print " uses bash"
	else
		print " does not use bash"
}
