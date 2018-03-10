#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This file is intended to be run at startup.  It ensures that the next 
# login will use a randomly chosen background image for this theme.

VERBOSE=0
log () {
  if [[ $VERBOSE -eq 1 ]]; then
    echo "$@"
  fi
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
shopt -s nullglob
files=(*.jpg)
numfiles=${#files[@]}
sumfiles=0
index=0
while [ $index -lt $numfiles ]; do
  let "sumfiles += $index"
  (( index++ ))
done
log "There are $numfiles jpg files in this directory."
log "The indexes of these files sum to $sumfiles."

# Figure out which number isn't represented in the filenames
sum=0
regex='background([0-9]{1,2})\.jpg'
for f in "${files[@]}"; do
  if [[ $f =~ $regex ]]; then
    let "sum += ${BASH_REMATCH[1]}"
  fi
done
log "sum is $sum"
current_num=$sumfiles
let "current_num -= $sum"
current_file="background$current_num.jpg"
log "The current file being used is normally $current_file"

# Figure out which file isn't of the pattern background\d{1,2}.jpg
# and change that file back to it's numbered form
for f in "${files[@]}"; do
  if [[ "$f" =~ "background.jpg" ]]; then
    log "$f is the errant file"
    mv background.jpg $current_file
  fi
done

# Then, choose a number in the desired range (all bgrnd files) at random
# and use that number to rename a file to be the new background image
random_num=$RANDOM
let "random_num %= $numfiles"
while [[ $random_num -eq $current_num ]]; do
  random_num=$RANDOM
  let "random_num %= $numfiles"
done
log $random_num
new_file="background$random_num.jpg"
mv $new_file background.jpg
