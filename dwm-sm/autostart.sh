#! /bin/bash
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

dte(){
  dte="$(date +"%A, %B %d | 🕒 %l:%M %p")"
  echo -e "$dte"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "🖪 $mem"
}

run setxkbmap -layout 'us,ru' -option 'grp:ctrls_toggle,grp_led:scroll',caps:escape

if [ -f /usr/lib/po*kit*-gnome/polkit-gnome-authentication-agent-1 ] ; then
    killall -9 run /usr/lib/po*kit*-gnome/polkit-gnome-authentication-agent-1
    run /usr/lib/po*kit*-gnome/polkit-gnome-authentication-agent-1
fi

if hash pcmanfm > /dev/null 2>&1 ; then
    run dbus-launch pcmanfm -d
fi
if hash udiskie > /dev/null 2>&1 ; then
    run udiskie
fi
if hash tilda > /dev/null 2>&1 ; then
    run tilda
fi
if hash picom > /dev/null 2>&1 ; then
    run picom --experimental-backends
elif hash compton > /dev/null 2>&1 ; then
    run compton
fi

run nm-applet
run xfce4-power-manager

run clipit
run volumeicon
run nitrogen --restore
run sxhkd -c ~/.dotfiles/config-sm/sxhkd/sxhkdrc-base
# run xautolock -time 50 -locker blurlock &

run xset -dpms
run xset s off

while true; do
     xsetroot -name "$(mem) | $(dte)"
     sleep 10s    # Update time every ten seconds
done &
