local gears = require("gears")
local awful = require("awful")


local clientkeys = gears.table.join(
	-- Toggle fullscreen
    awful.key(
		{ modkey,},
		"f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
	),

	-- Kill program
    awful.key(
        { modkey},
        "q",
        function (c) c:kill()                         end,
        {description = "close", group = "client"}
	),

	-- Toggle floating
    awful.key(
		{ modkey, "Shift" },
		"space",
		awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}
	),
	-- Swap with master
    awful.key(
		{ modkey, "Control" },
		"Return",
		function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}
	),

    awful.key({ modkey,},
		"n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}
	),
    awful.key({ modkey,},
		"m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}
	),
    awful.key(
		{ modkey, "Control" },
		"m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}
	),
    awful.key(
		{ modkey, "Shift"},
		"m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}
    ),



    awful.key(
        {modkey},
        'j',
        function()
            awful.client.focus.byidx(1)
        end,
        {description = 'focus next by index', group = 'client'}
    ),
    awful.key(
        {modkey},
        'k',
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = 'focus previous by index', group = 'client'}
    ),
    awful.key(
        { modkey, 'Shift'  },
        'j',
        function ()
            awful.client.swap.byidx(1)
        end,
        {description = 'swap with next client by index', group = 'client'}
    ),
    awful.key(
        { modkey, 'Shift' },
        'k',
        function ()
            awful.client.swap.byidx(-1)
        end,
        {description = 'swap with next client by index', group = 'client'}
    ),

    awful.key(
        {modkey},
        'u',
        awful.client.urgent.jumpto,
        {description = 'jump to urgent client', group = 'client'}
    ),

    awful.key(
        {modkey},
        'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'go back', group = 'client'}
    ),


    awful.key(
        {modkey},
        'n',
        function(c)
            c.minimized = true
        end,
        {description = 'minimize client', group = 'client'}
    ),

    awful.key(
        { modkey, 'Shift' },
        'c',
        function(c)
            local focused = awful.screen.focused()

            awful.placement.centered(c, {
                honor_workarea = true
            })
        end,
        {description = 'align a client to the center of the focused screen', group = 'client'}
    )
)

return clientkeys
