#!/bin/bash

#
#  Timer1986
#
#  file : install.sh
#
#  Created on: 13 yan. 2015.
#      Author: Sergey S.Sklyarov (kirra)
#
#

output_file_name="timer1986"
echo "Install..."

if [ ! -f "$output_file_name" ]
then
  echo "file: $output_file_name not found. It's possible, compile crashed."
else
  cp timer1986 /usr/local/bin/timer1986
  touch /usr/share/applications/1986BE91T.desktop
  echo "Copy $output_file_name to /usr/local/bin/timer1986"
  echo "Create desktop file /usr/share/applications/1986BE91T.desktop"
  echo "[Desktop Entry]" >  /usr/share/applications/1986BE91T.desktop
  echo "Version=0.1" >>  /usr/share/applications/1986BE91T.desktop
  echo "Name=Calc timer 1986BE91T" >>  /usr/share/applications/1986BE91T.desktop
  echo "Name[ru]=Расчёт таймера для К1986ВЕ91Т" >>  /usr/share/applications/1986BE91T.desktop
  echo "Comment=Calc timer K1986VE91T" >>  /usr/share/applications/1986BE91T.desktop
  echo "Comment[ru]=Расчёт таймера для К1986ВЕ91Т" >>  /usr/share/applications/1986BE91T.desktop
  echo "Type=Application" >>  /usr/share/applications/1986BE91T.desktop
  echo "Exec=timer1986" >>  /usr/share/applications/1986BE91T.desktop
  echo "Icon=applications-electronics" >>  /usr/share/applications/1986BE91T.desktop
  echo "StartupNotify=true" >>  /usr/share/applications/1986BE91T.desktop
  echo "Categories=Engineering;Electronics;Utility;Calculator;" >>  /usr/share/applications/1986BE91T.desktop
fi

echo "Done."

#
#  End file install.sh
#
