# User defined-functions should be before any BEGIN or END block
function getAverage(grade146, grade131, grade100W) {
    return ((grade146 + grade131 + grade100W) / 3)
}

BEGIN {FS=","}

# For every line greater than 1 (Skips the header that describes the columns)
# NR is the line number
# Must be defined in the line where the curly bracket is started 
NR > 1 {
    # Increment the element at the student
    # For every single student, add the score values to the element representing their name
    totalGradeSum[$2] += $3;
    totalGradeSum[$2] += $4;
    totalGradeSum[$2] += $5;

    # Call function getAverage and pass the parameters being the columns stating their grades
    gradeAverage[$2] = getAverage($3, $4, $5);
}

END {
    # Define starting points for lowest and top scoring students.
    # 0 in the arrays is the student name and 1 is the average score corresponding to that student
    lowestScoringStudent[1] = gradeAverage["Alice"];
    highestScoringStudent[1] = gradeAverage["Alice"];

    # For every element in the associative array print g, the studentID/index and the associated total grade sum, totalGradeSum[g]
	for (g in totalGradeSum) {
        print g, "has a total grade sum of", totalGradeSum[g];

        print g, "has an average grade of", gradeAverage[g];

        if (gradeAverage[g] >= 70) {
            print g, "passed";
        }
        else {
            print g, "failed";
        }

        # Line break for clarity
        print ""

        # Conditionals to find lowest and highest student scores
        if (gradeAverage[g] < lowestScoringStudent[1]) {
            lowestScoringStudent[0] = g;
            lowestScoringStudent[1] = gradeAverage[g];
        }
        
        if (gradeAverage[g] > highestScoringStudent[1]) {
            highestScoringStudent[0] = g;
            highestScoringStudent[1] = gradeAverage[g];
        }
	}
    print "The lowest scoring student is:", lowestScoringStudent[0];
    print "The highest scoring student is:", highestScoringStudent[0];
}