BEGIN { FS=":" }  # Delimiter set to :

{ shells[$7]++ }

END {
	for (s in shells) {
		print shells[s], "users are having", s, "as their default shell"
		}
	}
