--------------------------------------------------
-- FIXED ESP SYSTEM
--------------------------------------------------
local function applyESP(player)
	if player == LP then return end
	if not espEnabled then return end

	local function onCharacter(char)
		if espObjects[player] then
			espObjects[player]:Destroy()
			espObjects[player] = nil
		end

		local highlight = Instance.new("Highlight")
		highlight.Name = "QwertyESP"
		highlight.Adornee = char
		highlight.FillColor = Color3.fromRGB(255, 80, 80)
		highlight.OutlineColor = Color3.fromRGB(255,255,255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Parent = char

		espObjects[player] = highlight
	end

	if player.Character then
		onCharacter(player.Character)
	end

	player.CharacterAdded:Connect(onCharacter)
end

local function removeESP(player)
	if espObjects[player] then
		espObjects[player]:Destroy()
		espObjects[player] = nil
	end
end

--------------------------------------------------
-- ESP TOGGLE
--------------------------------------------------
EspBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	EspBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"

	if espEnabled then
		for _,plr in ipairs(Players:GetPlayers()) do
			applyESP(plr)
		end
	else
		for plr,_ in pairs(espObjects) do
			removeESP(plr)
		end
	end
end)

--------------------------------------------------
-- PLAYER HANDLING
--------------------------------------------------
Players.PlayerAdded:Connect(function(plr)
	if espEnabled then
		applyESP(plr)
	end
end)

Players.PlayerRemoving:Connect(function(plr)
	removeESP(plr)
end)
