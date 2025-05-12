# Set clean.csv as the goal file and run its dependencies to make it
all: clean.csv

trimmed.csv: raw.csv
	# Cut only columns 1, 2, and 5 for idm age, and score
	# $< > $@ inputs raw.csv to the cut and writes the output to trimmed.csv
	cut -d',' -f1,3,5 $< > $@

clean.csv: trimmed.csv
	# -F',' sets the delimiter. $$1 != "" makes sure that the id column is not empty to include it. Same w/ 2/5
	#  $< > $@ write output to target
	awk -F',' '$$1 != "" && $$2 != "" && $$3 != ""' $< > $@

# Tells the file that clean is a command and not some file
.PHONY: clean

clean:
	rm -f trimmed.csv clean.csv
