# backup-files.sh
## Purpose
This script allows the user to backup files from their home directory and save them to a Backups directory or whatever path is specified. Additionally, it can delete the old non compressed file and decompress compressed files.

It offers three modes:
1. Backup & compress
2. Backup, compress, & delete non-compressed
3. Decompress backup

## When is this useful?
This script could come in handy when running on a machine with limited disk space.

Instead of flat out deleting certain files you can now compress them to a smaller size and decompress them later on.

## How to use
1. Run backup-files.sh
2. Select one of the three options:
    1. Backup & compress
    2. Backup, compress, & delete non-compressed
    3. Decompress backup
3. If backup & compress is selected or the delete version, choose from the selection of files in your home directory which to backup
4. A directory has been made in your home directory called Backups where the compressed version is stored.
5. If Decompress backup is selected, select from the compressed files stored in the Backups folder
6. Then specify where to save the extracted file(s)
7. Extracted file is now saved in specified location

## Output
```
anthony_flores@instance-20250127-200635:~/cs131/a2$ ./backup-files.sh
1) Backup & compress			      3) Decompress backup
2) Backup, compress, & delete non-compressed
#? 1
You picked: Backup & compress

Files and directories in /home/anthony_flores
Select the file you would like to work with:
1) bin
2) cs131
3) ex
4) example
5) hi.txt
6) result.txt
7) snap
#? 4
You selected the directory: example
Proceeding with the selection: /home/anthony_flores/example

/home/anthony_flores/Backups does not exist...making directory
example/
example/c.log
example/b.sh
example/dir/
example/dir/d.csv
example/dir/e
example/a.txt
anthony_flores@instance-20250127-200635:~/cs131/a2$ ./backup-files.sh
1) Backup & compress			      3) Decompress backup
2) Backup, compress, & delete non-compressed
#? 3
You picked: Decompress backup

/home/anthony_flores/Backups exists...continuing with backup
Files and directories in /home/anthony_flores/Backups
Select the file you would like to work with:
1) example-2025-03-12-06:10:06.tar.gz
#? 1
You selected the compressed file: example-2025-03-12-06:10:06.tar.gz
Proceeding with the selection: /home/anthony_flores/Backups/example-2025-03-12-06:10:06.tar.gz

Where would you like to extract the files?
1) Extract to /home/anthony_flores/Backups/extracted/
2) Specify exact location
Enter your selection (1 or 2): 1
Files extracted to /home/anthony_flores/Backups/extracted/
```