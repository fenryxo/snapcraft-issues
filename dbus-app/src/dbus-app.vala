public class DbusApp : Gtk.Application
{
	Gtk.ApplicationWindow? win = null;
	string text = "Hello, Snapcraft!";
	Gtk.Label? label = null;
	DbusAppInterface ifce = null;
	uint ifce_id = 0;
	
	public DbusApp()
	{
		Object(
		application_id: "cz.fenryxo.DbusApp",
		flags: ApplicationFlags.FLAGS_NONE);
	}
	
	protected override void activate()
	{
		if (win == null)
		{
			win = new Gtk.ApplicationWindow(this);
			win.set_default_size(300, 300);
			win.title = "DbusApp";
			label = new Gtk.Label(text);
			win.add(label);
			win.show_all();
		}
		else
		{
			label.set_text("Unique instance activated.");
			win.present();
		}
	}
	
	public override bool dbus_register(DBusConnection conn, string object_path)
		throws Error
	{
		if (!base.dbus_register(conn, object_path))
			return false;
		ifce = new DbusAppInterface(this);
		ifce_id = conn.register_object(object_path, ifce);
		return true;
	}
	
	public override void dbus_unregister(DBusConnection conn, string object_path)
	{
		if (ifce_id > 0)
		{
			conn.unregister_object(ifce_id);
			ifce_id = 0;
		}
		base.dbus_unregister(conn, object_path);
	}
	
	public void said_hello()
	{
		text = "I've said hello over DBus.";
		if (label != null)
			label.set_text(text);
	}
	
	public static int main(string[] args)
	{
		var app = new DbusApp();
		return app.run(args);
	}
}

[DBus(name="cz.fenryxo.DbusApp")]
public class DbusAppInterface
{
	private unowned DbusApp app;
	
	public DbusAppInterface(DbusApp app)
	{
		this.app = app;
	}
	
	public string say_hello()
	{
		app.said_hello();
		return "Hello, DBus!";
	}
}
