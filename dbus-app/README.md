Issue with DBus-Activatable App
=============================

When a `{DBUS_ID}.service` file is installed into the `/usr/share/dbus-1/services`,
[the app/service](./dbus-app.vala) becomes DBus activatable. That means the app/service
is launched if there is any DBus call to {DBUS_ID} and the service hasn't started yet.

However, Snappy, unlike Flatpak, doesn't export DBus service files at all.


Example when the app is running:

```
$ fenryxo-dbus-app.run
$ dbus-send --print-reply --session --dest=cz.fenryxo.DbusApp /cz/fenryxo/DbusApp cz.fenryxo.DbusApp.SayHello
method return time=1479411455.922984 sender=:1.76 -> destination=:1.77 serial=20 reply_serial=2
   string "Hello, DBus!"

```

Example when the app is not running:

```
$ dbus-send --print-reply --session --dest=cz.fenryxo.DbusApp /cz/fenryxo/DbusApp cz.fenryxo.DbusApp.SayHello
Error org.freedesktop.DBus.Error.ServiceUnknown: The name cz.fenryxo.DbusApp was not provided by any .service files
1. Launch the application `$ fenryxo-dbus-app.run`
```

Expected result:

1. The app is launched.
2. The string "Hello, DBus!" is returned to the DBus caller.

