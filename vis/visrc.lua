require('vis')

vis.events.subscribe(vis.events.INIT, function()
    vis:command('set theme solarized')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set number')
    vis:command('set autoindent')
    vis:command('set tabwidth 4')
    vis:command('set expandtab')
    vis:command('set cursorline')
    vis:command('set show-tabs')
end)

