/**
 *  Timer1986
 * 
 *  file : Callback.vala
 *
 *  Created on: 16 dec. 2014.
 *      Author: Sergey S.Sklyarov (kirra)
 *
 */

namespace Callback
{
  public void on_changed_callback()
  {
    if (GUI.HCLK_entry.get_text().length == 0 |
        GUI.result_entry.get_text().length == 0)
    {
      stderr.printf("\nTimer 1986 : WARNING **: : applications have empty fields.\n");
    }
    else
    {
      switch (GUI.prescaler_combobox.active)
      {
        case 0  :  { GUI.current_prescaler = 1;   }; break;
        case 1  :  { GUI.current_prescaler = 2;   }; break;
        case 2  :  { GUI.current_prescaler = 4;   }; break;
        case 3  :  { GUI.current_prescaler = 8;   }; break;
        case 4  :  { GUI.current_prescaler = 16;  }; break;
        case 5  :  { GUI.current_prescaler = 32;  }; break;
        case 6  :  { GUI.current_prescaler = 64;  }; break;
        case 7  :  { GUI.current_prescaler = 128; }; break;
        default : { GUI.current_prescaler = 1;  };  break;
      }
      stderr.printf("\nTimer 1986 : INFO **: : current prescaler = %d\n", GUI.current_prescaler);
      uint32 current_hclk = (uint32)int.parse(GUI.HCLK_entry.get_text());
      uint32 current_divider = (uint32)GUI.divider_spin_box.adjustment.value;
      double current_result = (double)double.parse(GUI.result_entry.get_text());

      switch (GUI.HCLK_combobox.active)
      {
	      case 0 : current_hclk *= 1000000; break;
		    case 1 : current_hclk *= 1000; break;
		  }

      switch (GUI.result_combobox.active)
      {
	      case 0 : 
		    {
		      switch (GUI.last_result) /* sec */
		      {
		        case 1 : current_result *= 1000; break;
		        case 2 : current_result *= 1000000; break;
		      }
		    } break;

		    case 1 : 
        {
	        switch (GUI.last_result) /* ms */
	        {
	          case 0 : current_result /= 1000; break;
	          case 2 : current_result *= 1000; break;
	        }
	      } break;

        case 2 : 
	      {
	        switch (GUI.last_result) /* mcs */
	        {
	          case 0 : current_result /= 1000000; break;
	          case 1 : current_result /= 1000; break;
	        }
	      } break;		      	      
	    }

	    double current_timer_clk = (current_hclk/GUI.current_prescaler)/current_divider;

      switch (GUI.timer_clk_combobox.active)
      {
        case 0 : GUI.timer_clk_entry.set_text((current_timer_clk/1000000).to_string()); break;
        case 1 : GUI.timer_clk_entry.set_text((current_timer_clk/1000).to_string()); break;
        case 2 : GUI.timer_clk_entry.set_text(current_timer_clk.to_string()); break;
      }

      string template = (GUI.add_0x_checkbutton.active ? "0x" : "");
      template += (GUI.upper_case_checkbutton.active ? "%X" : "%x");
      stderr.printf(@"\nTimer 1986 : INFO **: : template string $template \n");

      GUI.timer_psg_entry.set_text(template.printf(current_divider - 1));

      double current_arr = (current_timer_clk/GUI.current_prescaler) * current_result;
      GUI.timer_arr_entry.set_text(template.printf((uint32)(current_arr * GUI.current_prescaler - 1)));
      
      uint32 div = (uint32) GUI.divider_spin_box.adjustment.value;
      
      if ((uint32)(current_arr * GUI.current_prescaler - 1) > 0xFFFF)
      {
        if (GUI.enable_check_borders_checkbutton.active)
        {
          div++;
          GUI.divider_spin_box.adjustment.value = div;
          on_changed_callback();
          GUI.status_bar_label.set_text("""<span color="#E3B822">Изменено значение делителя</span>""");
          GUI.status_bar_label.set_use_markup (true);
		      GUI.status_bar_label.set_line_wrap (true);
        }
        else
        {
          GUI.status_bar_label.set_text("""<span color="#FF0000">ARR за пределом 0xFFFF</span>""");
          GUI.status_bar_label.set_use_markup (true);
		      GUI.status_bar_label.set_line_wrap (true);
		    }
      }
      else
      {
          GUI.status_bar_label.set_text("""<span color="#009C00">Результат корректен</span>""");
          GUI.status_bar_label.set_use_markup (true);
		      GUI.status_bar_label.set_line_wrap (true);
      }
    }
  }
    
  public void on_select_combobox_callback()
  {
    uint32 timer_hclk = (uint32) int.parse(GUI.HCLK_entry.get_text());
	  switch (GUI.HCLK_combobox.active)
	  {
	    case 0 : 
		  {
		    switch (GUI.last_timer_hclk)
		    {
		      case 1 : timer_hclk /= 1000; break;
		      case 2 : timer_hclk /= 1000000; break;
		    }
		  } break;

      case 1 : 
      {
	      switch (GUI.last_timer_hclk)
	      {
	        case 0 : timer_hclk *= 1000; break;
	        case 2 : timer_hclk /= 1000; break;
	      }
	    } break;

      case 2 : 
      {
        switch (GUI.last_timer_hclk)
        {
          case 0 : timer_hclk *= 1000000; break;
          case 1 : timer_hclk *= 1000; break;
        }
      } break;		      	      
    }

    GUI.HCLK_entry.set_text(timer_hclk.to_string());
    GUI.last_timer_hclk = GUI.HCLK_combobox.active;	  
  }
}

/**
 * End file Callback.vala
 */
