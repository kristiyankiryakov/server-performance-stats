# server-performance-stats

Now, let’s review some parts of the previous Bash script.

First of all, we check if the script receives the process’s ID as a parameter. Then, we read the process’s status from the /proc/$PID/stat file and store it into an array.

We use the sed command to substitute anything in between parenthesis with an X character. We do this because the process’s name is placed inside parentheses and it can have whitespaces. If the process’s name has whitespaces and we don’t account for that situation, it would change the meaning of each column in the /proc/$PID/stat file.

After that, we get the process’s utime, stime, and starttime from the PROCESS_STAT array and store them into individual variables. We can notice we use the index 13, 14, and 21 instead of 14, 15, and 22. This is because Bash has zero-based arrays. So, the 14th column in the /proc/$PID/stat file becomes the 13th index in the array.

We also get the system’s uptime using the awk command after substituting the dot with a white space using the tr command. We do this because Bash’s arithmetic only works with integers.

Finally, we’ll also notice that we used let to perform the arithmetic operations.