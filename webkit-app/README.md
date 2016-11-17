Issue with WebKit App
=====================

When I start [a WebKitGTK+ based application](./webkit-app.vala), WebKitGTK+ cannot
find its binaries for secondary processes: WebKitWebProcess and WebKitNetworkProcess.

```
$ fenryxo-webkit-app.run
Gtk-Message: Failed to load module "canberra-gtk-module"
Gtk-Message: Failed to load module "canberra-gtk-module"
Unable to fork a new WebProcess: Failed to execute child process \
"/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/WebKitNetworkProcess" (No such file or directory).
Unable to fork a new WebProcess: Failed to execute child process \
"/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/WebKitWebProcess" (No such file or directory).
Unable to fork a new WebProcess: Failed to execute child process \
"/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/WebKitNetworkProcess" (No such file or directory).
Unable to fork a new WebProcess: Failed to execute child process \
"/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/WebKitWebProcess" (No such file or directory).
```

That's because these binaries have got snapped into
the /snap/fenryxo-webkit-app/NNN/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0 directory.

```
$ fenryxo-webkit-app.sh
[inside-snapp]$ ls /usr/lib/x86_64-linux-gnu/webkit2gtk-4.0
ls: cannot access '/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0': No such file or directory
[inside-snapp]$ echo $SNAP     
/snap/fenryxo-webkit-app/x2
[inside-snapp]$ ls $SNAP/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0
MiniBrowser  WebKitDatabaseProcess  WebKitNetworkProcess  \
WebKitPluginProcess  WebKitWebProcess  injected-bundle
```
