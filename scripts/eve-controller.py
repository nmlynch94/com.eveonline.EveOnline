#!/usr/bin/env python3
import sys
import subprocess
from gi.repository import Gio, GLib

BUS_NAME = "com.eveonline.EveController"
OBJECT_PATH = "/com/eveonline/EveController"
IFACE = "com.eveonline.EveController"
EVE_RUN_INTERNAL = "/app/bin/eve-run-internal"

INTROSPECTION_XML = f"""
<node>
  <interface name='{IFACE}'>
    <method name='RunEve'>
      <arg type='s' name='uri' direction='in'/>
    </method>
  </interface>
</node>
"""


class EveController:
    def __init__(self, initial_uri: str):
        self.initial_uri = initial_uri or ""
        self.loop = GLib.MainLoop()

        print("EveController: starting, initial_uri =", repr(self.initial_uri), flush=True)

        self.node_info = Gio.DBusNodeInfo.new_for_xml(INTROSPECTION_XML)
        self.iface_info = self.node_info.interfaces[0]

        self.owner_id = Gio.bus_own_name(
            Gio.BusType.SESSION,
            BUS_NAME,
            Gio.BusNameOwnerFlags.NONE,
            self.on_bus_acquired,
            self.on_name_acquired,
            self.on_name_lost,
        )

    def on_bus_acquired(self, connection, name):
        print("EveController: bus acquired, name =", name, flush=True)
        self.connection = connection

        # Register object for our interface
        self.connection.register_object(
            OBJECT_PATH,
            self.iface_info,
            self.handle_method_call,
            None,
            None,
        )

        # Always launch once on first run
        uri_to_use = self.initial_uri or ""
        print("EveController: initial launch of eve-run-internal with uri =", repr(uri_to_use), flush=True)
        self.launch_eve(uri_to_use)

    def on_name_acquired(self, connection, name):
        print("EveController: name acquired:", name, flush=True)

    def on_name_lost(self, connection, name):
        print("EveController: name lost:", name, flush=True)
        self.loop.quit()

    def handle_method_call(self, connection, sender, object_path,
                           interface_name, method_name, parameters, invocation):
        print(
            "EveController: method call:",
            "sender=", sender,
            "iface=", interface_name,
            "method=", method_name,
            "params=", parameters,
            flush=True,
        )

        if interface_name == IFACE and method_name == "RunEve":
            (uri,) = parameters
            print("EveController: RunEve called with uri =", repr(uri), flush=True)
            self.launch_eve(uri)
            invocation.return_value(None)
        else:
            print("EveController: unknown method", flush=True)
            invocation.return_dbus_error(
                "com.eveonline.EveController.Error",
                f"Unknown method {interface_name}.{method_name}",
            )

    def launch_eve(self, uri: str):
        uri = uri or ""
        cmd = [EVE_RUN_INTERNAL]
        if uri:
            cmd.append(uri)

        print("EveController: spawning:", cmd, flush=True)
        try:
            subprocess.Popen(cmd)
        except Exception as e:
            print("EveController: FAILED to spawn", cmd, "error:", e, flush=True)

    def run(self):
        try:
            self.loop.run()
        except KeyboardInterrupt:
            print("EveController: interrupted, exiting", flush=True)
            self.loop.quit()


def main():
    # argv[1] is the initial uri from eve-run wrapper (may be empty)
    initial_uri = sys.argv[1] if len(sys.argv) > 1 else ""
    controller = EveController(initial_uri)
    controller.run()


if __name__ == "__main__":
    main()
