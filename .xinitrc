#!/bin/sh

# dual monitors
# if below doesn't work, check the display names from the output of `xrandr`.
VGA=`xrandr -q | grep 'VGA.' --only-matching`
LVDS=`xrandr -q | grep 'LVDS.' --only-matching`
xrandr --output $VGA --preferred --primary
xrandr --output $LVDS --preferred
xrandr --output $LVDS --right-of $VGA
unset VGA
unset LVDS

# remap some keys
xmodmap ~/.Xmodmap

# set solid color "wallpaper"
# xsetroot -solid '#1e1e1e'

# proxy settings
proxy_host=144.16.192.218
proxy_port=8080
proxy=http://$proxy_host:$proxy_port/
no_proxy="localhost,example.com"
export http_proxy=$proxy
export HTTP_PROXY=$proxy
export https_proxy=$proxy
export HTTPS_PROXY=$proxy
export ftp_proxy=$proxy
export FTP_PROXY=$proxy
export no_proxy=$no_proxy

# for Java apps
export _JAVA_OPTIONS="-Dhttp.proxyHost=$proxy_host -Dhttp.proxyPort=$proxy_port -Dhttps.proxyHost=$proxy_host -Dhttps.proxyPort=$proxy_port -Dhttp.noProxyHosts=\"$no_proxy\""

# startup applications
redshiftgui &
#wicd-gtk --tray &
/usr/bin/mpd && mpc pause
emacs --daemon &
terminator &
pidgin &
dropboxd &
mpdscribble &
#conky &
synapse &
keepassx ~/Dropbox/Private/keepassx.kdb &
# synchronize primary and secondary clipboards
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# initialize session depending on what was chosen at the login screen
DEFAULT_SESSION=lxde

case $1 in
lxde)
        tile --daemonize &
        batti &
        exec ck-launch-session startlxde
	;;
awesome)
        exec ck-launch-session dbus-launch $HOME/.xinitrc-real
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
