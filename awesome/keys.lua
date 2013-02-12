pulseaudio = require('delightful.widgets.pulseaudio')

globalkeys = awful.util.table.join(globalkeys,
                                   -- mpd control
                                   awful.key({ modkey, "Control" }, "d"     , function () awful.util.spawn("mpc toggle") end ),
                                   awful.key({ modkey, "Control" }, "a"     , function () awful.util.spawn("mpc prev") end ),
                                   awful.key({ modkey, "Control" }, "s"     , function () awful.util.spawn("mpc next") end ),
                                   awful.key({ modkey, "Control" }, "e"     , function () awful.util.spawn("mpc seek +10") end ),
                                   awful.key({ modkey, "Control" }, "w"     , function () awful.util.spawn("mpc seek -10") end ),
                                   awful.key({ modkey,           }, "d"     , function () awful.util.spawn("mpd_control -t") end ),
                                   awful.key({ modkey, "Shift"   }, "d"     , function () awful.util.spawn("mpd_control -j") end ),

                                   awful.key({ modkey            }, "g"     , function () quakeconsole:toggle() end),

                                   -- window switcher
                                   -- awful.key({ modkey,           }, "q"     , function () awful.util.spawn("switch_to") end ),

                                   -- screen locker
                                   awful.key({ modkey, "Control" }, "l"     , function () awful.util.spawn("slimlock") end ),

                                   -- task killer
                                   awful.key({ modkey            }, "x"     , function () awful.util.spawn("xkill") end ),

                                   -- screenshot
                                   awful.key({         "Control" }, "Print" , function () awful.util.spawn("scrot") end ),

                                   -- media keys
                                   awful.key({ }, "XF86AudioPlay"           , function () awful.util.spawn("mpc toggle") end),
                                   awful.key({ }, "XF86AudioStop"           , function () awful.util.spawn("mpc stop") end),
                                   awful.key({ }, "XF86AudioPrev"           , function () awful.util.spawn("mpc prev") end),
                                   awful.key({ }, "XF86AudioNext"           , function () awful.util.spawn("mpc next") end),
                                   awful.key({ }, "XF86AudioRaiseVolume"    , function () pulseaudio.pulseaudio_control('up', 1) end),
                                   awful.key({ }, "XF86AudioLowerVolume"    , function () pulseaudio.pulseaudio_control('down', 1) end),
                                   awful.key({ }, "XF86AudioMute"           , function () pulseaudio.pulseaudio_control('toggle', 1) end),

                                   -- low-level volume control to go beyond 100% if needed
                                   awful.key({ modkey, "Control" }, "Up"    , function () awful.util.spawn("vol_ctrl inc 10") end),
                                   awful.key({ modkey, "Control" }, "Down"  , function () awful.util.spawn("vol_ctrl dec 10") end),

                                   -- surfraw search
                                   awful.key({ modkey            },  "q",
                                             function()
                                                awful.prompt.run({ prompt = "<span foreground='#7f9f7f'>Google Search:</span> "},
                                                                 mypromptbox[mouse.screen].widget,
                                                                 function(input) awful.util.spawn_with_shell("google_search " .. input) end, nil)
                                             end),


                                   -- basic calculator
                                   awful.key({ modkey            }, "F11",
                                             function ()
                                                awful.prompt.run({ prompt = "Calculate: " }, mypromptbox[mouse.screen].widget,
                                                                 function (expr)
                                                                    local result = awful.util.eval("return (" .. expr .. ")")
                                                                    naughty.notify({ text = expr .. " = " .. result, timeout = 10 })
                                                                 end)
                                             end)
                                  )


-- run-or-raise keys:
-- Table entry format: ["key"]={"function", "match string", "optional attribute to match"}
-- The "key" will be bound as "modkey + key".
-- The "function" is what gets run if no matching client windows are found.
-- Usual attributes are "class","instance", or "name". If no attribute is given it defaults to "class".
-- The "match string"  will match substrings.  So "Firefox" will match "blah Firefox blah"
-- Use xprop to get this info from a window.  WM_CLASS(STRING) gives you "instance", "class".  WM_NAME(STRING) gives you the name of the selected window (usually something like the web page title for browsers, or the file name for emacs).

module("ror")
table5={
   ["a"]={"eiskaltdcpp-qt", "Eiskaltdcpp" },
   ["b"]={"smplayer", "Smplayer" },
   ["c"]={"chromium", "Chromium"},
   ["e"]={"emacsclient -a '' -c", "Emacs"},
   ["f"]={"firefox", "Firefox"},
   ["h"]={"surf google.com", "Surf"},
   ["p"]={"pidgin", "Pidgin"},
   ["s"]={"spacefm", "Spacefm"},
   ["t"]={"terminator", "Terminator"},
   ["v"]={"vlc", "Vlc"},
   ["y"]={"conkeror google.com", "Conkeror"},
   ["z"]={"evince", "Evince"},
}
