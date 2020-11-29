# Bash-Scripts

backup.sh- A simple bash script that takes an individual file or directory and back it up into a tar file. The first input is the directory where the file should be saved and the second is the file that we want backed up. The backed up file will contain the name of the original file follwoed by the date it was backed up.

srcdiff.sh - This script compares the text files between two directories and will print wether or not the text file is from one directory is missing from another,or wether they both exist but differ in contents.

ParseLogs- This contains a script that parses through webserver logs and produces metrics. Firstly, it print the number of requests per each browser, it then prints the number of distinct users per day, and finally it prints the top 20 most popular product requests.
