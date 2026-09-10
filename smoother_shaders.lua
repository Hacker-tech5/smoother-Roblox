-- smoother_shaders.lua
-- Insert this as a LocalScript inside StarterPlayer > StarterPlayerScripts

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local function ensureEffect(className, name)
	local existing = Lighting:FindFirstChild(name)
	if existing then
		return existing
	end

	local effect = Instance.new(className)
	effect.Name = name
	effect.Parent = Lighting
	return effect
end

local bloom = ensureEffect("BloomEffect", "SmootherBloom")
local color = ensureEffect("ColorCorrectionEffect", "SmootherColor")
local sunRays = ensureEffect("SunRaysEffect", "SmootherSunRays")
local atmosphere = ensureEffect("Atmosphere", "SmootherAtmosphere")

Lighting.Ambient = Color3.fromRGB(48, 52, 60)
Lighting.OutdoorAmbient = Color3.fromRGB(68, 72, 82)
Lighting.Brightness = 2.2
Lighting.GlobalShadows = true
Lighting.ClockTime = 14
Lighting.GeographicLatitude = 30
Lighting.ShadowSoftness = 0.45
Lighting.ExposureCompensation = 0.15
Lighting.FogColor = Color3.fromRGB(180, 190, 210)
Lighting.FogStart = 180
Lighting.FogEnd = 4800

bloom.Enabled = true
bloom.Intensity = 0.7
bloom.Size = 26
bloom.Threshold = 1.2

color.Enabled = true
color.Brightness = 0.08
color.Contrast = 0.12
color.Saturation = 0.9
color.TintColor = Color3.fromRGB(255, 234, 210)

sunRays.Enabled = true
sunRays.Intensity = 0.08
sunRays.Spread = 0.28

atmosphere.Enabled = true
atmosphere.Color = Color3.fromRGB(170, 190, 220)
atmosphere.Decay = Color3.fromRGB(207, 186, 148)
atmosphere.Glare = 0.12
atmosphere.Haze = 2.2
atmosphere.Density = 0.32
atmosphere.Offset = 0.2

local timeValue = 0
RunService.RenderStepped:Connect(function(deltaTime)
	timeValue += deltaTime
	local pulse = 0.7 + math.sin(timeValue * 0.8) * 0.08
	bloom.Intensity = pulse
	sunRays.Intensity = 0.07 + math.sin(timeValue * 0.6) * 0.025
end)
