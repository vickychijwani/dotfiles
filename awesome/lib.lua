-- Helper functions library

-- Grab environment
local awful = {
    util    = awful.util,
    tag     = awful.tag,
    rules   = awful.rules,
    client  = awful.client
}
local capi  = {
    mouse   = mouse,
    client  = client,
    screen  = screen
}
local table    = table
local pairs    = pairs
local next     = next
local sexec    = awful.util.spawn_with_shell
local match    = awful.rules.match
local match_any    = awful.rules.match_any
local ismarked = awful.client.ismarked

-- iterator: cycle over a table starting from the next element
local function cycle(t, item)
    local index = awful.util.table.hasitem(t, item)
    local size  = table.getn(t)
    local count = 0
    return function ()
        index = next(t, index) or 1; count = count + 1
        if not (count > size) then return t[index] end
    end
end

----- Run or Raise, and scratch applications --------------------------------

-- The idea of run or raise is to switch to a client if running, else spawn it.
-- Scratch applications are those that are frequently accessed, to do a short
-- task( shell, file manager, mpd client ).

-- run_or_raise :
-- brings up the next matching client,
-- spawn cmd, if none matches,
-- hide if called on a focussed scratch app.
--
-- @params :
-- cmd        - the command to execute( eg. : urxvt )
-- properties - a table of properties to match against clients( eg. : {class = "Urxvt"} )

function run_or_raise(cmd, properties, scratch, many)
    local clients = capi.client.get()
    local focused = awful.client.next(0)
    for c in cycle(clients, focused) do
        if  (many and match_any(c, properties)) or ( not many and match(c, properties) ) then
            local scratch = scratch or false
            if (c == focused) then
                if scratch then c.hidden = true else return end
            else
                if scratch then
                    -- not on any tag, or scratch, show client on current tag
                    awful.client.movetotag(awful.tag.selected(), c)
                else
                    -- else, pop to first tag client is visible on
                    awful.tag.viewonly(c:tags()[1])
                end
                -- show, and focus the client
                c.hidden = false
                client.focus = c
                c:raise()
            end
            return
        end
    end
    -- client not found, spawn it
    awful.util.spawn(cmd)
end

-- cycle through marked clients
function cycle_marked()
    local clients = capi.client.get()
    local focused = awful.client.next(0)
    for c in cycle(clients, focused) do
        if ismarked(c) then
            local ctags = c:tags()
            if table.getn(ctags) == 0 then
                -- not on any tag, or scratch, show client on current tag
                awful.client.movetotag(awful.tag.selected(), c)
            else
                -- else, pop to first tag client is visible on
                awful.tag.viewonly(ctags[1])
            end
            -- And then focus the client
            client.focus = c
            c:raise()
            return
        end
    end
end

-- launch a program if it is not already running
function run(prg)
    if not prg then return nil end
    sexec("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

