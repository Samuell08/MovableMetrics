local elapsed = 0

function mod(a, b)
    return a - math.floor(a / b) * b
end

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

local t = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
t:SetPoint("CENTER", f, "CENTER")
t:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")

f:SetScript("OnUpdate", function()
  local _, _, latency = GetNetStats();
  local fps = GetFramerate();
    elapsed = elapsed + 1
    if mod(elapsed, 30) == 0 then
      t:SetText(string.format("%d FPS  %d ms", fps, latency))
    end
end)
