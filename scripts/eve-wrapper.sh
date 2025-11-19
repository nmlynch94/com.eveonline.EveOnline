#!/bin/sh
set -e

BUS_NAME="com.eveonline.EveController"
OBJECT_PATH="/com/eveonline/EveController"
IFACE="com.eveonline.EveController"

uri="$1"

# Check if the controller is already running via D-Bus
if gdbus call --session \
    --dest org.freedesktop.DBus \
    --object-path /org/freedesktop/DBus \
    --method org.freedesktop.DBus.GetNameOwner "$BUS_NAME" > /dev/null 2>&1; then

    exec gdbus call --session \
        --dest "$BUS_NAME" \
        --object-path "$OBJECT_PATH" \
        --method "$IFACE.RunEve" \
        "${uri:-}"
fi

# No controller, start new one
# 
# This is to let eve launcher reopen without closing all the clients
# By default if the eve launcher opens, we open some clients, then close the eve launcher, we can't reopen it. Flatpak tries to create a second sandbox, and the eve prefix freezes all existing clients for some reason
# It works if we run eve-run-internal again inside the same sandbox, so we achieve this through this controller.
# Now, when eve is launched again, it will call this controller and then exit instead of trying to create a second flatpak sandbox
exec /app/bin/eve-controller "${uri:-}"
