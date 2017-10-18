function reloadConfig(files)
  doReload = false
  for _,path in pairs(files) do
    if hs.fs.displayName(path) and path:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

function selectZoomMenuItem(menuPath)
  local zoom = hs.appfinder.appFromName("zoom.us")

  local done = false
  hs.timer.doUntil(
    function ()
      return done
    end,
    function ()
      done = zoom:selectMenuItem(menuPath)
    end,
    0.2
  )

  hs.alert.show(menuPath[#menuPath])
end

function unmuteZoom()
  selectZoomMenuItem({"Meeting", "Unmute Audio"})
end

function muteZoom()
  selectZoomMenuItem({"Meeting", "Mute Audio"})
end

pushToTalkZoomHotkey = hs.hotkey.new({"cmd"}, "a", unmuteZoom, muteZoom)
hs.window.filter.new("zoom.us")
  :subscribe(hs.window.filter.windowFocused, function () pushToTalkZoomHotkey:enable() end)
  :subscribe(hs.window.filter.windowUnfocused, function () pushToTalkZoomHotkey:disable() end)

hs.alert.show("Config loaded")
