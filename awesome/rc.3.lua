-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- delightful widgets
require("delightful.widgets.pulseaudio")
require("delightful.widgets.battery")
require("delightful.widgets.datetime")
-- This is the order the widgets appear in the wibox.
install_delightful = {
    delightful.widgets.pulseaudio,
    delightful.widgets.battery,
    delightful.widgets.datetime,
}

-- Widget configuration
delightful_config = {
   [delightful.widgets.battery] = {
      battery         = 'BAT0',
      update_interval = 5,
   },
   [delightful.widgets.pulseaudio] = {
      mixer_command = 'pavucontrol',
   },
}

-- Prepare the container that is used when constructing the wibox
local delightful_container = { widgets = {}, icons = {} }
if install_delightful then
    for _, widget in pairs(awful.util.table.reverse(install_delightful)) do
        local config = delightful_config and delightful_config[widget]
        local widgets, icons = widget:load(config)
        if widgets then
            if not icons then
                icons = {}
            end
            table.insert(delightful_container.widgets, awful.util.table.reverse(widgets))
            table.insert(delightful_container.icons,   awful.util.table.reverse(icons))
        end
    end
end

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- Each screen has its own tag table.
tags = {}
if screen.count() >= 2 then
   tags[1] = awful.tag({ "browse",   "edit",     "docs",     "media",    "other"    }, 1,
                       { layouts[3], layouts[1], layouts[3], layouts[3], layouts[3] })
   tags[2] = awful.tag({ "chat",     "shell",    "files",    "other"    }, 2,
                       { layouts[2], layouts[1], layouts[3], layouts[3] })
else
   tags[1] = awful.tag({ "browse",   "shell",    "edit",     "files",    "docs",     "media",    "chat",     "other"    }, 1,
                       { layouts[3], layouts[1], layouts[1], layouts[3], layouts[3], layouts[3], layouts[2], layouts[3] })
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "lock screen", "slimlock" },
                                    { "restart", "sudo reboot" },
                                    { "shutdown", "sudo halt" },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- CPU temperature widget
temp = widget({ type = "textbox" })
vicious.register(temp, vicious.widgets.thermal, "$1℃", 19, { "coretemp.0", "core"})

-- separator - dummy text widget
separator = widget({ type = "textbox" })
separator.text = " | "

-- Pacman Widget
pacwidget = widget({type = "textbox"})

pacwidget_t = awful.tooltip({ objects = { pacwidget }})

vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("pacman -Qu")
                    local str = ''
                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    s:close()
                    return args[1] .. " updates"
                end, 300, "Arch")
                -- 300 means check every 5 minutes

-- separator - dummy text widget
separator2 = widget({ type = "textbox" })
separator2.text = " | "

-- Volume in percent
require("utils")
vol = widget({ type = "textbox" })
vol.text = "Vol: " .. execute_command("vol_ctrl") .. "%"

vol_timer = timer({ timeout = 1 })
vol_timer:add_signal("timeout", function() vol.text = execute_command("vol_ctrl") .. "%" end)
vol_timer:start()

-- separator - dummy text widget
separator3 = widget({ type = "textbox" })
separator3.text = "| "


-- CPU usage widget
-- cpuwidget = widget({ type = "textbox" })

-- cpuwidget = awful.widget.graph()
-- cpuwidget:set_width(50)
-- cpuwidget:set_height(24)
-- cpuwidget:set_background_color(beautiful.bg_minimize)
-- cpuwidget:set_color(beautiful.fg_normal)
-- cpuwidget:set_gradient_colors({ beautiful.fg_darker, beautiful.fg_normal, beautiful.fg_lighter })

-- memwidget = awful.widget.graph()
-- memwidget:set_width(10)
-- memwidget:set_height(24)
-- memwidget:set_background_color(beautiful.bg_minimize)
-- memwidget:set_color(beautiful.fg_normal)

-- Register CPU widget
-- vicious.register(cpuwidget, vicious.widgets.cpu, function (widget, args) return args[1] end)
-- vicious.register(cpuwidget, vicious.widgets.cpu, "$1")
-- vicious.register(memwidget, vicious.widgets.mem, "$1")

-- Drop-down terminal
local quake = require("quake")
quakeconsole = quake({ terminal = "xterm",
                       argname = "-name %s -e ncmpcpp",
                       name = "xterm-quake",
                       height = 1.0,
                       screen = 1 })


-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s , height = "20" })
    -- Add widgets to the wibox - order matters

    local widgets_front = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        temp,
        separator,
        pacwidget,
        separator2,
        vol,
        separator3,
    }
    local widgets_middle = {}
    for delightful_container_index, delightful_container_data in pairs(delightful_container.widgets) do
       for widget_index, widget_data in pairs(delightful_container_data) do
          table.insert(widgets_middle, widget_data)
          if delightful_container.icons[delightful_container_index] and delightful_container.icons[delightful_container_index][widget_index] then
             table.insert(widgets_middle, delightful_container.icons[delightful_container_index][widget_index])
          end
       end
    end
    local widgets_end = {
       s == 1 and mysystray or nil,
       -- memwidget.widget,
       -- cpuwidget.widget,
       mytasklist[s],
       layout = awful.widget.layout.horizontal.rightleft
    }
    mywibox[s].widgets = awful.util.table.join(widgets_front, widgets_middle, widgets_end)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },            "r",     function () awful.util.spawn("dmenu_run -p 'Run:' -fn '-*-*-medium-r-*-*-18-*-*-*-*-*-*-*'") end)

    -- , awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
require("keys")

-- load the 'run or raise' function
require("aweror")

-- generate and add the 'run or raise' key bindings to the globalkeys table
globalkeys = awful.util.table.join(globalkeys, aweror.genkeys(modkey))

root.keys(globalkeys)
-- }}}

-- {{{ Rules
if screen.count() >= 2 then
   awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = true,
                       keys = clientkeys,
                       buttons = clientbuttons,
                       size_hints_honor = false } },
      { rule = { class = "Firefox" },
        properties = { tag = tags[1][1] } },
      { rule = { class = "Chromium" },
        properties = { tag = tags[1][1] } },
      { rule = { class = "Pidgin" },
        properties = { tag = tags[2][1], floating = true } },
      { rule = { class = "Terminator" },
        properties = { tag = tags[2][2] } },
      { rule = { class = "Emacs" },
        properties = { tag = tags[1][2] } },
      { rule = { class = "Spacefm" },
        properties = { tag = tags[2][3] } },
      { rule = { class = "Eiskaltdcpp-qt" },
        properties = { tag = tags[2][4] } },

      -- media players and ncmpcpp running inside Guake
      { rule = { class = "Guake" },
        properties = { screen = 1 } },
      { rule = { class = "Vlc" },
        properties = { tag = tags[1][4] } },
      { rule = { class = "Smplayer" },
        properties = { tag = tags[1][4] } },
      { rule = { class = "xbmc" },
        properties = { tag = tags[1][4] } },

      -- PDF viewers
      { rule = { class = "Zathura" },
        properties = { tag = tags[1][3] } },
      { rule = { class = "Tabbed" },
        properties = { tag = tags[1][3] } },
      { rule = { class = "Evince" },
        properties = { tag = tags[1][3] } }
   }
else
   awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = true,
                       keys = clientkeys,
                       buttons = clientbuttons } },
      { rule = { class = "Pidgin" },
        properties = { tag = tags[1][7], floating = true } },
      { rule = { class = "Terminator" },
        properties = { tag = tags[1][2] } },
      { rule = { class = "Emacs" },
        properties = { tag = tags[1][3] } },
      { rule = { class = "Spacefm" },
        properties = { tag = tags[1][4] } },
      { rule = { class = "Eiskaltdcpp-qt" },
        properties = { tag = tags[1][8] } },

      -- media players and ncmpcpp running inside Guake
      { rule = { class = "Guake" },
        properties = { screen = 1 } },
      { rule = { class = "Vlc" },
        properties = { tag = tags[1][6] } },
      { rule = { class = "Smplayer" },
        properties = { tag = tags[1][6] } },
      { rule = { class = "xbmc" },
        properties = { tag = tags[1][6] } },

      -- PDF viewers
      { rule = { class = "Zathura" },
        properties = { tag = tags[1][5] } },
      { rule = { class = "Tabbed" },
        properties = { tag = tags[1][5] } },
      { rule = { class = "Evince" },
        properties = { tag = tags[1][5] } }
   }
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
