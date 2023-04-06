-- Runs Auto.bat

function run_auto_mpv()
    os.execute("..\\auto.bat")
  end
  
  mp.add_key_binding("CTRL+SHIFT+u", "run_auto_mpv", run_auto_mpv)  