local mp = require 'mp'
local options = require 'mp.options'

local opts = {
    -- Please set both of these variables from "portable_config\script-opts\jelly-index-loader.conf".
    preroll = "Netflix_Colorful_Jellyfin_Pre-roll.mp4",
    jellyfin_index = ".\\portable_config\\cache\\jellyfin\\indexed-jellyfin-libary.m3u"
}

function load_jelly_index()
    mp.commandv("loadfile", ".\\portable_config\\cache\\jellyfin\\" .. opts.preroll)
    mp.commandv("loadfile", ".\\portable_config\\cache\\jellyfin\\indexed-jellyfin-libary.m3u", "append")
end

mp.add_key_binding("ctrl+j", "load_jelly_index", load_jelly_index)

