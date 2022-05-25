local gears = require("gears");
local awful = require("awful");
local beautiful = require("beautiful")
local awesome = awesome
local hotkeys_popup = require("awful.hotkeys_popup")
local default_apps = require("configurations.default-apps")
require('awful.autofocus')

local altkey = "Mod1"


local globalkeys = gears.table.join(
    awful.key(
        { modkey,},
        'F1',
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    awful.key(
        { modkey, "Control" },
        'r',
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key({modkey, 'Control'},
        'q',
        awesome.quit,
        {description = 'quit awesome', group = 'awesome'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'q',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'layout'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = 'increase the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = 'decrease the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = 'increase the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'decrease the number of columns', group = 'layout'}
    ),

    -- Next layout
    awful.key(
        { modkey,},
        "space",
        function () awful.layout.inc(1) end,
        {description = "select next", group = "layout"}
    ),

    awful.key(
        { modkey, "Control" },
        "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    awful.key(
        {modkey},
        'o',
        function()
            local incgap = 5
            awful.tag.incgap(incgap);
            beautiful.useless_gap =  beautiful.useless_gap + incgap
        end,
        {description = 'increase gap', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'o',
        function()
            local incgap = -5
            awful.tag.incgap(incgap);
            beautiful.useless_gap =  beautiful.useless_gap + incgap
        end,
        {description = 'decrease gap', group = 'layout'}
    ),
    awful.key(
        {modkey},
        'w',
        awful.tag.viewprev,
        {description = 'view previous tag', group = 'tag'}
    ),
    awful.key(
        {modkey},
        's',
        awful.tag.viewnext,
        {description = 'view next tag', group = 'tag'}
    ),
    awful.key(
        {modkey},
        'Escape',
        awful.tag.history.restore,
        {description = 'alternate between current and previous tag', group = 'tag'}
    ),
    awful.key(
        { modkey, 'Control' },
        'w',
        function ()
          -- tag_view_nonempty(-1)
          local focused = awful.screen.focused()
          for _ = 1, #focused.tags do
                awful.tag.viewidx(-1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = 'view previous non-empty tag', group = 'tag'}
    ),
    awful.key({ modkey, 'Control' },
        's',
        function ()
            -- tag_view_nonempty(1)
            local focused =  awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = 'view next non-empty tag', group = 'tag'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'F1',
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = 'focus the previous screen', group = 'screen'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'F2',
        function()
            awful.screen.focus_relative(1)
        end,
        { description = 'focus the next screen', group = 'screen'}
    ),
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal('request::activate')
                c:raise()
            end
        end,
        {description = 'restore minimized', group = 'screen'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn('light -A 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = 'increase brightness by 10%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn('light -U 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = 'decrease brightness by 10%', group = 'hotkeys'}
    ),
    -- ALSA volume control
    awful.key(
        {altkey},
        'Up',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'increase volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {altkey},
        'Down',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'decrease volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {altkey},
        'm',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle', false)
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.spawn('mpc next', false)
        end,
        {description = 'next music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.spawn('mpc prev', false)
        end,
        {description = 'previous music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle', false)
        end,
        {description = 'play/pause music', group = 'hotkeys'}

    ),
    awful.key(
        {},
        'XF86AudioMicMute',
        function()
            awful.spawn('amixer set Capture toggle', false)
        end,
        {description = 'mute microphone', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerDown',
        function()
            --
        end,
        {description = 'shutdown skynet', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerOff',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        {description = 'arandr', group = 'hotkeys'}
    ),

    awful.key(
        {modkey},
        '`',
        function()
            awesome.emit_signal('module::quake_terminal:toggle')
        end,
        {description = 'dropdown application', group = 'launcher'}
    ),
    awful.key(
        { },
        'Print',
        function ()
            awful.spawn.easy_async_with_shell(default_apps.full_screenshot,function() end)
        end,
        {description = 'fullscreen screenshot', group = 'Utility'}
    ),
    awful.key(
        {modkey, 'Shift'},
        's',
        function ()
            awful.spawn.easy_async_with_shell(default_apps.area_screenshot,function() end)
        end,
        {description = 'area/selected screenshot', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        't',
        function()
            awesome.emit_signal('widget::blue_light:toggle')
        end,
        {description = 'toggle redshift filter', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'b',
        function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
            end
        end,
        {description = 'toggle systray visibility', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'c',
        function ()
          awesome.emit_signal("control-center::toggle")
        end,
        {description = 'toggle control center', group = 'Utility'}
    ),

    awful.key(
        {modkey},
        'i',
        function ()
          awesome.emit_signal("calendar::toggle")
        end,
        {description = 'toggle calendar visibility', group = 'Utility'}
    ),

    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.spawn(default_apps.lock_screen, false)
        end,
        {description = 'lock the screen', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'Return',
        function()
            awful.spawn(default_apps.terminal)
        end,
        {description = 'open default terminal', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'e',
        function()
            awful.spawn(default_apps.file_manager)
        end,
        {description = 'open default file manager', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'f',
        function()
            awful.spawn(default_apps.web_browser)
        end,
        {description = 'open default web browser', group = 'launcher'}
    ),
    awful.key(
        {'Control', 'Shift'},
        'Escape',
        function()
            awful.spawn(default_apps.terminal .. ' ' .. 'htop')
        end,
        {description = 'open system monitor', group = 'launcher'}
    ),
    -- My keybindings
    awful.key(
        { modkey },
        "r",
        --function() awful.spawn("rofi -show drun -columns 2 -theme codeDark -no-show-icons") end
        function() awful.spawn(default_apps.app_menu, false) end,
        {description = "Application launcher", group = 'launcher'}
    )
)

return globalkeys
