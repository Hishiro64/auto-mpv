-- Runs Auto.bat

function run_auto_mpv()
    os.execute(".\\wget.exe http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/auto.bat -O ..\\auto.bat")
    os.execute("..\\auto.bat")
  end
  
  mp.add_key_binding("CTRL+SHIFT+u", "run_auto_mpv", run_auto_mpv)  