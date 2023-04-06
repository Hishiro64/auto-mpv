-- Runs Auto.bat

function run_auto_mpv()
    os.execute(".\\wget.exe https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/auto.bat -O ..\\auto.bat")
    os.execute("..\\auto.bat")
  end
  
  mp.add_key_binding("CTRL+SHIFT+u", "run_auto_mpv", run_auto_mpv)  