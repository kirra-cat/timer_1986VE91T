/**
 *  Timer1986
 * 
 *  file : main.vala
 *
 *  Created on: 16 dec. 2014.
 *      Author: Sergey S.Sklyarov (kirra)
 *
 */

using GUI;

namespace Application
{
  public static const int VERSION = 1;
  public static const int SUBVERSION = 1;

  public static int main (string[] args) 
  {
    try 
    {
      Gtk.init (ref args);

      var window = new LayoutWidgets.create_gui();
      window.icon = new Gdk.Pixbuf.from_file ("/usr/share/pixmaps/icon_1986.png");
      window.show_all();

      Gtk.main();
    } 
    catch (Error err)
    {
      stderr.printf ("\nTimer 1986 : ERROR **: : Could not load application icon: %s\n", err.message);
    }
    return 0;
  }
}


/**
 * End file main.vala
 */
