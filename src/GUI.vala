/**
 *  Timer1986
 * 
 *  file : GUI.vala
 *
 *  Created on: 16 dec. 2014.
 *      Author: Sergey S.Sklyarov (kirra)
 *
 */
 
namespace GUI
{
  public Gtk.Label HCLK_label;
  public Gtk.Entry HCLK_entry;
  public Gtk.ComboBoxText HCLK_combobox;
    
  public Gtk.Label prescaler_label; 
  public Gtk.ComboBoxText prescaler_combobox;
    
  public Gtk.Label divider_label;
  public Gtk.Entry divider_entry;
    
  public Gtk.Label timer_clk_label;
  public Gtk.Entry timer_clk_entry;
  public Gtk.ComboBoxText timer_clk_combobox;
    
  public Gtk.Label result_label;
  public Gtk.Entry result_entry;
  public Gtk.ComboBoxText result_combobox;
    
  public Gtk.Label timer_psg_label;
  public Gtk.Entry timer_psg_entry;
    
  public Gtk.Label timer_arr_label;
  public Gtk.Entry timer_arr_entry;
    
  public Gtk.CheckButton upper_case_checkbutton;
  public Gtk.CheckButton add_0x_checkbutton;
  public Gtk.CheckButton enable_check_borders_checkbutton;
  
  public Gtk.Label status_bar_label;
  
  public uint last_timer_hclk = 0;
  public uint last_result = 0;
  public int active_prescaler;
  public int current_HCLK_units;
  public int current_prescaler;
    
  public class LayoutWidgets : Gtk.Window
  {         
    public Gtk.Clipboard clipboard;
        
    public LayoutWidgets.create_gui()
    {
      this.title = "Расчёт таймера для 1986ВЕ91";
      this.window_position = Gtk.WindowPosition.CENTER;
      this.destroy.connect (Gtk.main_quit);
      clipboard = Gtk.Clipboard.get_for_display(this.get_display(), Gdk.SELECTION_CLIPBOARD);
		  this.set_resizable(false);
		  
		  var grid = new Gtk.Grid();
		  
		  /* HCLK */
		  HCLK_label = new Gtk.Label.with_mnemonic("Тактовая частота контроллера");
		  grid.attach(HCLK_label, 0, 0, 1, 1);
		  HCLK_entry = new Gtk.Entry();
		  HCLK_entry.set_alignment((float)0.5);
		  grid.attach(HCLK_entry, 1, 0, 1, 1);
		  HCLK_entry.changed.connect(Callback.on_changed_callback);
		  		  		  
		  HCLK_combobox = new Gtk.ComboBoxText();
		  HCLK_combobox.append_text("МГц");
		  HCLK_combobox.append_text("кГц");
		  HCLK_combobox.append_text("Гц");
		  HCLK_combobox.halign = Gtk.Align.END;
		  HCLK_combobox.active = 0;
		  
		  grid.attach(HCLK_combobox, 2, 0, 1, 1);
		  HCLK_combobox.changed.connect(Callback.on_select_combobox_callback);
		  
		  /* Prescaler */
		  prescaler_label = new Gtk.Label.with_mnemonic("Предделитель");
		  grid.attach(prescaler_label, 0, 1, 1, 1);
		  
		  prescaler_combobox = new Gtk.ComboBoxText();
		  prescaler_combobox.append_text("1");
		  prescaler_combobox.append_text("2");
      prescaler_combobox.append_text("4");
		  prescaler_combobox.append_text("8");
		  prescaler_combobox.append_text("16");
		  prescaler_combobox.append_text("32");
		  prescaler_combobox.append_text("64");
		  prescaler_combobox.append_text("128");
		  prescaler_combobox.active = 0;	
		  grid.attach(prescaler_combobox, 1, 1, 2, 1);
		  prescaler_combobox.changed.connect(Callback.on_changed_callback);
		  
		  /* Divider */	  
		  divider_label = new Gtk.Label.with_mnemonic("Делитель основного счёта");
		  grid.attach(divider_label, 0, 2, 1, 1);

		  divider_entry = new Gtk.Entry();
		  divider_entry.set_alignment((float) 0.5);
		  grid.attach(divider_entry, 1, 2, 2, 1);
		  divider_entry.changed.connect(Callback.on_changed_callback);
		  
		  /* Timer clock */
		  timer_clk_label = new Gtk.Label.with_mnemonic("Тактовая частота таймера");
		  grid.attach(timer_clk_label, 0, 3, 1, 1);

		  timer_clk_entry = new Gtk.Entry();
		  timer_clk_entry.set_alignment((float) 0.5);
		  grid.attach(timer_clk_entry, 1, 3, 1, 1);
		  
		  timer_clk_combobox = new Gtk.ComboBoxText();
		  timer_clk_combobox.append_text("МГц");
		  timer_clk_combobox.append_text("кГц");
		  timer_clk_combobox.append_text("Гц");
		  timer_clk_combobox.active = 0;
		  active_prescaler = (uint8)timer_clk_combobox.active;
		  grid.attach(timer_clk_combobox, 2, 3, 1, 1);
		  		  
		  timer_clk_combobox.changed.connect(Callback.on_changed_callback);
		  
		  /* Result */
		  result_label = new Gtk.Label.with_mnemonic("Получить");
		  result_entry = new Gtk.Entry();
		  grid.attach(result_label, 0, 4, 1, 1);
		  result_entry.changed.connect(Callback.on_changed_callback);
		  
		  result_entry = new Gtk.Entry();
		  result_entry.set_alignment((float) 0.5);
		  grid.attach(result_entry, 1, 4, 1, 1);
		  result_entry.changed.connect(Callback.on_changed_callback);
		  
		  result_combobox = new Gtk.ComboBoxText();
		  result_combobox.append_text("сек");
 		  result_combobox.append_text("мс");
		  result_combobox.append_text("мкс");
		  result_combobox.active = 0;
		  grid.attach(result_combobox, 2, 4, 1, 1);
		  result_combobox.changed.connect(Callback.on_changed_callback);
		  
		  /* MDR_TIMERx->PSG */
		  timer_psg_label = new Gtk.Label.with_mnemonic("TIMERx->PSG");
		  grid.attach(timer_psg_label, 0, 5, 1, 1);
		  
		  timer_psg_entry = new Gtk.Entry();
		  timer_psg_entry.set_alignment((float) 0.5);
		  timer_psg_entry.set_icon_from_icon_name(Gtk.EntryIconPosition.SECONDARY, "gtk-copy");
		  timer_psg_entry.icon_press.connect((pos, event) =>
		  {
		    if (pos == Gtk.EntryIconPosition.SECONDARY)
		    {
		      if (timer_psg_entry.get_text().length == 0)
		        stderr.printf("\nTimer 1986 : WARNING **: : field timer_psg_entry is empty.\n");
		      else
		        clipboard.set_text(timer_psg_entry.text, -1);	
		    }	    
		  });
		  grid.attach(timer_psg_entry, 1, 5, 2, 1);
		  
		  /* MDR_TIMERx->ARR */
		  timer_arr_label = new Gtk.Label.with_mnemonic("TIMERx->ARR");
		  grid.attach(timer_arr_label, 0, 6, 1, 1);
		  
		  timer_arr_entry = new Gtk.Entry();
		  timer_arr_entry.set_alignment((float) 0.5);
		  timer_arr_entry.set_icon_from_icon_name(Gtk.EntryIconPosition.SECONDARY, "gtk-copy");
		  timer_arr_entry.icon_press.connect((pos, event) =>
		  {
		    if (pos == Gtk.EntryIconPosition.SECONDARY)
		    {
		      if (timer_arr_entry.get_text().length == 0)
		        stderr.printf("\nTimer 1986 : WARNING **: : field timer_arr_entry is empty.\n");
		      else
		        clipboard.set_text(timer_arr_entry.text, -1);	
		    }	    
		  });
		  grid.attach(timer_arr_entry, 1, 6, 2, 1);
		  
		  upper_case_checkbutton = new Gtk.CheckButton();
		  upper_case_checkbutton.active = true;
		  upper_case_checkbutton.label = "Верхний регистр";
		  grid.attach(upper_case_checkbutton, 0, 7, 1, 1);
		  upper_case_checkbutton.notify["active"].connect(Callback.on_changed_callback);
		  
		  add_0x_checkbutton = new Gtk.CheckButton();
		  add_0x_checkbutton.active = true;
		  add_0x_checkbutton.label = "Добавлять 0x";
		  grid.attach(add_0x_checkbutton, 1, 7, 1, 1);
		  add_0x_checkbutton.notify["active"].connect(Callback.on_changed_callback);
		  
		  enable_check_borders_checkbutton = new Gtk.CheckButton();
		  enable_check_borders_checkbutton.active = true;
		  enable_check_borders_checkbutton.label = "Подстраивать до 16 бит";
		  grid.attach(enable_check_borders_checkbutton, 0, 8, 1, 1);
		  
		  status_bar_label = new Gtk.Label("""<span color="#009C00">Добра Вам!</span>""");
		  status_bar_label.set_use_markup (true);
		  status_bar_label.set_line_wrap (true);
		  grid.attach(status_bar_label, 1, 8, 1, 1);
		  
		  int vesion = Application.VERSION;
		  int subversion = Application.SUBVERSION;
		  var version_label = new Gtk.Label.with_mnemonic(@"ver. $vesion.$subversion");
		  version_label.halign = Gtk.Align.END;
		  grid.attach(version_label, 2, 7, 1, 1);
		  		  
		  /* Add all widgets to window */		  
		  this.add(grid);
    }
  }
}
/**
 * End file GUI.vala
 */
