-- Calls jelly-indexer.pyw to index your entire Jellyfin libary and export it.

require 'mp.options'

  -- Please set both of these variables from "portable_config\script-opts\jelly-indexer.conf".
local opts = {
  link = "<link-to-your-Jellyfin-instance>",
  key = "<API-Key-from-your-Jellyfin-instance>"
}

read_options(opts, "jelly-indexer")

function update_jelly_index()
    local args = {".\\pythonw.exe", ".\\jelly-indexer.pyw", opts.link, opts.key}
    mp.commandv("run", unpack(args))
  end
    
  mp.add_key_binding("CTRL+SHIFT+j", "update_jelly_index", update_jelly_index)