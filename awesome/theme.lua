---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "cantarell 12"
theme.icon_dir      = "~/.config/awesome/icons"

---- themes (uncomment exactly one of zenburn or default)
---- zenburn
-- {{{ Colors
theme.fg_normal = "#DCDCDC"
theme.fg_focus  = "#ECECEC"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#1E2320"
theme.bg_focus  = "#3F3F3F"
theme.bg_urgent = "#FF0000"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#1E2320"
-- theme.titlebar_[normal|focus]
-- }}}

---- default
-- theme.bg_normal     = "#222222"
-- theme.bg_focus      = "#535d6c"
-- theme.bg_urgent     = "#ff0000"
-- theme.bg_minimize   = "#444444"

-- theme.fg_normal     = "#aaaaaa"
-- theme.fg_darker     = "#888888"
-- theme.fg_lighter    = "#dddddd"
-- theme.fg_focus      = "#ffffff"
-- theme.fg_urgent     = "#ffffff"
-- theme.fg_minimize   = "#ffffff"

-- theme.border_width  = "2"
-- theme.border_normal = "#000000"
-- theme.border_focus  = "#535d6c"
-- theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.icon_dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.icon_dir .. "/taglist/squarew.png"

theme.tasklist_floating_icon = theme.icon_dir .. "/layouts/floating.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.awesome_icon = theme.icon_dir .. "/awesome32.png"
theme.menu_submenu_icon = theme.icon_dir .. "/submenu.png"
theme.menu_height = "24"
theme.menu_width  = "200"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- titlebar
titlebar_icon_dir                               = theme.icon_dir .. "/titlebar"

theme.titlebar_close_button_normal              = titlebar_icon_dir .. "/close_normal.png"
theme.titlebar_close_button_focus               = titlebar_icon_dir .. "/close_focus.png"

theme.titlebar_ontop_button_normal_inactive     = titlebar_icon_dir .. "/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = titlebar_icon_dir .. "/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = titlebar_icon_dir .. "/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = titlebar_icon_dir .. "/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = titlebar_icon_dir .. "/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = titlebar_icon_dir .. "/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = titlebar_icon_dir .. "/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = titlebar_icon_dir .. "/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = titlebar_icon_dir .. "/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = titlebar_icon_dir .. "/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = titlebar_icon_dir .. "/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = titlebar_icon_dir .. "/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_icon_dir .. "/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_icon_dir .. "/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = titlebar_icon_dir .. "/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = titlebar_icon_dir .. "/maximized_focus_active.png"

-- wallpaper
-- theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/default/background.png" }
-- theme.wallpaper_cmd = { "awsetbg /home/vicky/Pictures/Wallpapers/GoT/house-stark-2.jpg" }
theme.wallpaper_cmd = { "awsetbg /home/vicky/Pictures/Wallpapers/House/time-changes-everything-1600x900.jpg" }

-- layout icons
layout_icon_dir         = theme.icon_dir .. "/layouts"
theme.layout_fairh      = layout_icon_dir .. "/fairh.png"
theme.layout_fairv      = layout_icon_dir .. "/fairv.png"
theme.layout_floating   = layout_icon_dir .. "/floating.png"
theme.layout_magnifier  = layout_icon_dir .. "/magnifier.png"
theme.layout_max        = layout_icon_dir .. "/max.png"
theme.layout_fullscreen = layout_icon_dir .. "/fullscreen.png"
theme.layout_tilebottom = layout_icon_dir .. "/tilebottom.png"
theme.layout_tileleft   = layout_icon_dir .. "/tileleft.png"
theme.layout_tile       = layout_icon_dir .. "/tile.png"
theme.layout_tiletop    = layout_icon_dir .. "/tiletop.png"
theme.layout_spiral     = layout_icon_dir .. "/spiral.png"
theme.layout_dwindle    = layout_icon_dir .. "/dwindle.png"

-- separator icon for widgets
theme.separator_icon = theme.icon_dir .. "/misc/20x20/separator.png"

-- delightful error icon
theme.delightful_error               = theme.icon_dir .. "/misc/error.png"

-- icons for delightful battery widget
battery_icon_dir                     = theme.icon_dir .. "/battery"
theme.delightful_battery_ac          = battery_icon_dir .. "/battery-full-ac.png"
theme.delightful_battery_full        = battery_icon_dir .. "/battery-full.png"
theme.delightful_battery_medium_high = battery_icon_dir .. "/battery-medium-high.png"
theme.delightful_battery_medium      = battery_icon_dir .. "/battery-medium.png"
theme.delightful_battery_medium_low  = battery_icon_dir .. "/battery-medium-low.png"
theme.delightful_battery_low         = battery_icon_dir .. "/battery-low.png"
theme.delightful_not_found           = battery_icon_dir .. "/battery-not-found.png"

-- icons for delightful volume widget
volume_icon_dir           = theme.icon_dir .. "/volume"
theme.delightful_vol      = volume_icon_dir .. "/volume-high.png"
theme.delightful_vol_max  = volume_icon_dir .. "/volume-high.png"
theme.delightful_vol_med  = volume_icon_dir .. "/volume-medium.png"
theme.delightful_vol_min  = volume_icon_dir .. "/volume-low.png"
theme.delightful_vol_zero = volume_icon_dir .. "/volume-zero.png"
theme.delightful_vol_mute = volume_icon_dir .. "/volume-muted.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
