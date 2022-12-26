#!/bin/bash

STEAM_GAME_ID=550
GAME_BINARY=hl2_linux

export HOME=$DEBUG_REAL_HOME

steam steam://run/$STEAM_GAME_ID -mat_vsync 0 $@ &
sleep 5
GAME_PID=`pgrep $GAME_BINARY`
echo '#!/bin/sh' > steam-env-vars.sh
while read -d $'\0' ENV; do NAME=`echo $ENV | cut -d= -f1`; VAL=`echo $ENV | cut -d= -f2`; echo "export $NAME=\"$VAL\""; done < /proc/$GAME_PID/environ >> steam-env-vars.sh
chmod +x steam-env-vars.sh

kill -9 $GAME_PID