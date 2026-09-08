#! /bin/sh
#
# Setup Kiosk mode for Alpine Linux


USER=kiosk
KEYBOARD_LAYOUT=us
KEYBOARD_MODEL=mac
WIDTH=1024
HEIGHT=768
BROWSER=chromium
PRIVATE=yes
TABS=yes
URL=https://next-gallery-tawny.vercel.app/

# Install Xorg
#
setup-xorg-base
apk add xrandr setxkbmap xset xsetroot
# apk add xterm xeyes xcalc

# Enable Community repo
#

# Install Browser
#
apk add chromium

# Automatic login, no VTs, silent boot
#
cp /etc/inittab /etc/inittab.bak
cat << EOF > /etc/inittab
::sysinit:/sbin/openrc -q -C sysinit
::sysinit:/sbin/openrc -q -C boot
::wair:/sbin/openrc -q -C default
tty1::respawn:/bin/login -f kiosk
#tty2::respawn:/sbin/getty 38400 tty2
EOF

# Autostart Xorg
#
cat << EOF > /etc/skel/.profile
  startx 2> /dev/null
EOF

# Xorg Session

cat << EOF > /etc/skel/.xinitrc
  setxkbmap $KEYBOARD_LAYOUT $KEYBOARD_MODEL
  exec chromium-browser
EOF

# Disable Xorg VT Switch

cat << EOF > /etc/X11/xorg.conf
Section "ServerFlags"
    Option "DontVTSwitch" "true"
    Option "DontZap" "true"
EndSection
EOF

# Create user

adduser $USER -D





# Silent Boot

echo "" > /etc/motd
echo "" > /etc/issue


