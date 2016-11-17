
void main(string[] argv)
{
    Gtk.init(ref argv);
    var win = new Gtk.Window();
    win.set_size_request(1024, 800);
    var web_view = new WebKit.WebView();
    win.add(web_view);
    win.delete_event.connect(() => {Gtk.main_quit(); return true;});
    win.show_all();
    Idle.add(() => {web_view.load_uri("http://snapcraft.io/"); return false;});
    Gtk.main();
}
