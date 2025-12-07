-- load configuration file
MovableMetrics = MovableMetrics or {}

local elapsed = 0

-- modulo
function mod(a, b)
    return a - math.floor(a / b) * b
end

-- define frame
local f = CreateFrame("Button", "PerformanceFrame", UIParent)
f:SetPoint("CENTER", UIParent, 0, 0)
f:SetWidth(80)
f:SetHeight(20)
f:SetScale(1)
f:SetMovable(true)
f:SetUserPlaced(true)
f:SetClampedToScreen(true)
f:SetScript('OnMouseDown', function()
  if IsControlKeyDown() then
    this:RegisterForClicks()
    this:StartMoving()
  end
end)
f:SetScript('OnMouseUp', function()
  this:StopMovingOrSizing()
  this:RegisterForClicks'LeftButtonDown'
end)
f:SetFrameStrata'FULLSCREEN_DIALOG'

-- define text inside the frame
local t = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
t:SetPoint("CENTER", f, "CENTER")
t:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")

-- configure according to configuration file on load
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function()
  if MovableMetrics.hidden then
      HideUIPanel(f)
      print("MovableMetrics hidden, use /mm toggle to un-hide")
  end
end)

-- update text value every 30 frames
f:SetScript("OnUpdate", function()
  local _, _, latency = GetNetStats();
  local fps = GetFramerate();
    elapsed = elapsed + 1
    if mod(elapsed, 30) == 0 then
      t:SetText(string.format("%d FPS  %d ms", fps, latency))
    end
end)

-- handle slash commands
local function handleSlashCommand(msg)
  msg = msg or ""
  local cmd = string.lower(msg)

  if cmd == "toggle" then
    if f:IsVisible() then
      HideUIPanel(f)
      MovableMetrics.hidden = 1
    else
      ShowUIPanel(f)
      MovableMetrics.hidden = 0
    end
  else
    print("=== MovableMetrics Commands ===")
    print("  /mm toggle - Toggle metrics")
  end
end

-- register slash commands
SLASH_MM1 = "/mm"
SlashCmdList["MM"] = handleSlashCommand
