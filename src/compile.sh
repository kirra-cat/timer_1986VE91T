#!/bin/bash

#
#  Timer1986
#
#  file : compile.sh
#
#  Created on: 16 dec. 2014.
#      Author: Sergey S.Sklyarov (kirra)
#
#

time=$(date +%s)

output_file_name="timer1986"
valac_version=$(valac --version)

echo ${valac_version}

if [ ! -f "$output_file_name" ]
then
  echo "file: $output_file_name not found. "
else
  echo "old file $output_file_name removed."
  rm "$output_file_name"
fi

echo "Start compile..."
 
  valac -X -lm --disable-warnings \
  --pkg gtk+-3.0 \
  GUI.vala \
  Callback.vala \
  main.vala --output "$output_file_name"
 
if [ ! -f "$output_file_name" ]
then
  echo "Compile failed"
else
  echo "Compile is successful! Created file: ${output_file_name}"
fi

count_temp_file=$(ls -la | grep ".*~$" | wc -l)
 
if [ "$count_temp_file" -ne 0 ]
then
  echo "temp files:"
  ls -l | grep ".*~$"
  echo "Remove temp files.."
  rm *~
  echo "Removed ${count_temp_file} files. Done"
fi

total_time=$(($(date +%s)-$time))
echo "time: ${total_time} sec."

#
#  End file compile.sh
#
