-- // SURVIVE YOUR IDEAS - NEON PURPLE DISASTER AGGREGATOR MENU
-- // Executor Compatible (Luau)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Bảo vệ / Xóa UI cũ nếu chạy lại script
local GUI_NAME = "SYI_NeonPurpleDisasterHub"
local function getParentGui()
	local ok, res = pcall(function()
		return gethui and gethui() or CoreGui
	end)
	return (ok and res) or LocalPlayer:WaitForChild("PlayerGui")
end

local parentGui = getParentGui()
if parentGui:FindFirstChild(GUI_NAME) then
	parentGui[GUI_NAME]:Destroy()
end

-- // CẤU HÌNH TỪ KHÓA & VÙNG QUÉT THẢM HOẠ
local DisasterKeywords = {
	"disaster", "thảm họa", "tham hoa", "event", "hazard", "meteor", "tsunami",
	"earthquake", "tornado", "volcano", "lava", "flood", "storm", "lightning",
	"blizzard", "blackout", "zombie", "virus", "radiation", "acid", "alien",
	"asteroid", "fire", "explosion", "sinkhole", "hurricane", "apocalypse"
}

local ScanRoots = {
	workspace,
	game:GetService("ReplicatedStorage"),
	game:GetService("Lighting")
}

-- // HÀM HỖ TRỢ TẠO UI NHANH
local function newInstance(className, props, parent)
	local inst = Instance.new(className)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then
			inst[k] = v
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

local function addCorner(parent, radius)
	return newInstance("UICorner", {
		CornerRadius = UDim.new(0, radius or 10)
	}, parent)
end

local function addStroke(parent, color, thickness, transparency)
	return newInstance("UIStroke", {
		Color = color or Color3.fromRGB(185, 65, 255),
		Thickness = thickness or 1.5,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}, parent)
end

local function addGradient(parent, c1, c2, rotation)
	return newInstance("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, c1),
			ColorSequenceKeypoint.new(1, c2)
		}),
		Rotation = rotation or 0
	}, parent)
end

-- // BẢNG MÀU TÍM NEON
local Theme = {
	BgMain = Color3.fromRGB(15, 7, 26),
	BgCard = Color3.fromRGB(25, 12, 44),
	BgCardHover = Color3.fromRGB(38, 18, 66),
	BgTopBar = Color3.fromRGB(21, 9, 38),
	NeonMain = Color3.fromRGB(186, 54, 255),
	NeonBright = Color3.fromRGB(232, 128, 255),
	NeonDeep = Color3.fromRGB(115, 22, 204),
	TextMain = Color3.fromRGB(248, 240, 255),
	TextDim = Color3.fromRGB(178, 148, 214),
	AccentCyan = Color3.fromRGB(190, 95, 255)
}

-- // TẠO SCREEN GUI
local ScreenGui = newInstance("ScreenGui", {
	Name = GUI_NAME,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 999999
}, parentGui)

-- Nút bật/tắt nhanh (Floating Toggle)
local ToggleButton = newInstance("TextButton", {
	Name = "ToggleBtn",
	Size = UDim2.new(0, 148, 0, 36),
	Position = UDim2.new(0, 18, 0.5, -18),
	BackgroundColor3 = Theme.BgTopBar,
	Text = "⚡ SYI MENU",
	TextColor3 = Theme.NeonBright,
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	AutoButtonColor = false
}, ScreenGui)
addCorner(ToggleButton, 18)
addStroke(ToggleButton, Theme.NeonMain, 1.6, 0.1)
addGradient(ToggleButton, Color3.fromRGB(36, 13, 64), Color3.fromRGB(18, 7, 32), 45)

-- Khung chính (Main Menu)
local MainFrame = newInstance("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 470, 0, 360),
	Position = UDim2.new(0.5, -235, 0.5, -180),
	BackgroundColor3 = Theme.BgMain,
	BorderSizePixel = 0,
	ClipsDescendants = true
}, ScreenGui)
addCorner(MainFrame, 14)
addStroke(MainFrame, Theme.NeonMain, 2, 0.05)
addGradient(MainFrame, Color3.fromRGB(22, 9, 38), Color3.fromRGB(12, 5, 20), 135)

-- Thanh tiêu đề (TopBar)
local TopBar = newInstance("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1, 0, 0, 46),
	BackgroundColor3 = Theme.BgTopBar,
	BorderSizePixel = 0
}, MainFrame)
addCorner(TopBar, 14)
addGradient(TopBar, Color3.fromRGB(45, 15, 82), Color3.fromRGB(20, 8, 36), 90)

-- Che góc dưới của TopBar để phẳng đẹp
newInstance("Frame", {
	Size = UDim2.new(1, 0, 0, 12),
	Position = UDim2.new(0, 0, 1, -12),
	BackgroundColor3 = Theme.BgTopBar,
	BorderSizePixel = 0
}, TopBar)

-- Đường viền neon dưới TopBar
newInstance("Frame", {
	Size = UDim2.new(1, 0, 0, 2),
	Position = UDim2.new(0, 0, 1, -2),
	BackgroundColor3 = Theme.NeonMain,
	BorderSizePixel = 0
}, TopBar)

local TitleLabel = newInstance("TextLabel", {
	Size = UDim2.new(1, -120, 1, 0),
	Position = UDim2.new(0, 14, 0, 0),
	BackgroundTransparency = 1,
	Text = "SURVIVE YOUR IDEAS • DISASTER HUB",
	TextColor3 = Theme.TextMain,
	Font = Enum.Font.GothamBlack,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

local SubBadge = newInstance("TextLabel", {
	Size = UDim2.new(0, 62, 0, 20),
	Position = UDim2.new(1, -104, 0.5, -10),
	BackgroundColor3 = Theme.NeonDeep,
	Text = "NEON PRO",
	TextColor3 = Theme.NeonBright,
	Font = Enum.Font.GothamBold,
	TextSize = 10
}, TopBar)
addCorner(SubBadge, 6)
addStroke(SubBadge, Theme.NeonBright, 1, 0.25)

local CloseBtn = newInstance("TextButton", {
	Size = UDim2.new(0, 28, 0, 28),
	Position = UDim2.new(1, -36, 0.5, -14),
	BackgroundColor3 = Color3.fromRGB(48, 16, 78),
	Text = "✕",
	TextColor3 = Theme.NeonBright,
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	AutoButtonColor = false
}, TopBar)
addCorner(CloseBtn, 8)
addStroke(CloseBtn, Theme.NeonMain, 1.2, 0.3)

-- Thanh công cụ: Tìm kiếm + Quét lại + Copy tất cả
local ToolBar = newInstance("Frame", {
	Name = "ToolBar",
	Size = UDim2.new(1, -24, 0, 36),
	Position = UDim2.new(0, 12, 0, 56),
	BackgroundTransparency = 1
}, MainFrame)

local SearchBox = newInstance("TextBox", {
	Size = UDim2.new(1, -184, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = Theme.BgCard,
	PlaceholderText = "🔍 Tìm từ thảm họa...",
	PlaceholderColor3 = Theme.TextDim,
	Text = "",
	TextColor3 = Theme.TextMain,
	Font = Enum.Font.Gotham,
	TextSize = 12,
	ClearTextOnFocus = false
}, ToolBar)
addCorner(SearchBox, 8)
addStroke(SearchBox, Theme.NeonMain, 1.2, 0.35)

local ScanBtn = newInstance("TextButton", {
	Size = UDim2.new(0, 86, 1, 0),
	Position = UDim2.new(1, -176, 0, 0),
	BackgroundColor3 = Theme.NeonDeep,
	Text = "↻ Quét lại",
	TextColor3 = Theme.TextMain,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	AutoButtonColor = false
}, ToolBar)
addCorner(ScanBtn, 8)
addStroke(ScanBtn, Theme.NeonBright, 1.2, 0.2)

local CopyAllBtn = newInstance("TextButton", {
	Size = UDim2.new(0, 84, 1, 0),
	Position = UDim2.new(1, -84, 0, 0),
	BackgroundColor3 = Theme.BgCard,
	Text = "📋 Copy List",
	TextColor3 = Theme.NeonBright,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	AutoButtonColor = false
}, ToolBar)
addCorner(CopyAllBtn, 8)
addStroke(CopyAllBtn, Theme.NeonMain, 1.2, 0.25)

-- Thanh trạng thái tổng hợp
local StatusBar = newInstance("Frame", {
	Name = "StatusBar",
	Size = UDim2.new(1, -24, 0, 26),
	Position = UDim2.new(0, 12, 0, 98),
	BackgroundColor3 = Color3.fromRGB(22, 10, 38),
	BorderSizePixel = 0
}, MainFrame)
addCorner(StatusBar, 7)
addStroke(StatusBar, Theme.NeonMain, 1, 0.5)

local StatusLabel = newInstance("TextLabel", {
	Size = UDim2.new(1, -16, 1, 0),
	Position = UDim2.new(0, 8, 0, 0),
	BackgroundTransparency = 1,
	Text = "Tổng hợp từ thảm họa: 0 mục | Auto-Scan: Bật",
	TextColor3 = Theme.NeonBright,
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left
}, StatusBar)

-- Khung cuộn danh sách thảm họa
local ListScroll = newInstance("ScrollingFrame", {
	Name = "DisasterList",
	Size = UDim2.new(1, -24, 1, -138),
	Position = UDim2.new(0, 12, 0, 130),
	BackgroundColor3 = Color3.fromRGB(18, 8, 31),
	BorderSizePixel = 0,
	ScrollBarThickness = 5,
	ScrollBarImageColor3 = Theme.NeonMain,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y
}, MainFrame)
addCorner(ListScroll, 10)
addStroke(ListScroll, Theme.NeonMain, 1.2, 0.35)

local ListLayout = newInstance("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.Name
}, ListScroll)

newInstance("UIPadding", {
	PaddingTop = UDim.new(0, 8),
	PaddingBottom = UDim.new(0, 8),
	PaddingLeft = UDim.new(0, 8),
	PaddingRight = UDim.new(0, 8)
}, ListScroll)

-- // TÍNH NĂNG KÉO THẢ (DRAG) CHO MAINFRAME & TOGGLEBTN
local function makeDraggable(frame, handle)
	handle = handle or frame
	local dragging = false
	local dragInput, dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(MainFrame, TopBar)
makeDraggable(ToggleButton, ToggleButton)

-- // HỆ THỐNG TỔNG HỢP TỪ THẢM HỌA (DISASTER AGGREGATOR)
local CollectedDisasters = {} -- [wordLower] = { name = string, source = string, count = number }

local function containsDisasterKeyword(text)
	if typeof(text) ~= "string" or #text < 2 then
		return false
	end
	local lower = string.lower(text)
	for _, kw in ipairs(DisasterKeywords) do
		if string.find(lower, kw, 1, true) then
			return true
		end
	end
	return false
end

local function registerDisasterWord(word, sourceInfo)
	if typeof(word) ~= "string" then return end
	local cleaned = string.match(word, "^%s*(.-)%s*$")
	if not cleaned or #cleaned < 2 or #cleaned > 80 then return end

	local key = string.lower(cleaned)
	if not CollectedDisasters[key] then
		CollectedDisasters[key] = {
			name = cleaned,
			source = sourceInfo or "Detected",
			count = 1
		}
	else
		CollectedDisasters[key].count += 1
	end
end

local function inspectObjectForDisasters(obj)
	-- 1. Tên Object / TextLabel / TextButton / ValueBase
	if containsDisasterKeyword(obj.Name) then
		registerDisasterWord(obj.Name, obj.ClassName .. " Name")
	end

	if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
		if containsDisasterKeyword(obj.Text) then
			registerDisasterWord(obj.Text, "UI Text")
		end
	elseif obj:IsA("ValueBase") then
		local valStr = tostring(obj.Value)
		if containsDisasterKeyword(valStr) then
			registerDisasterWord(valStr, obj.ClassName)
		end
	end

	-- 2. Attributes của object
	for attrName, attrVal in pairs(obj:GetAttributes()) do
		if containsDisasterKeyword(attrName) then
			registerDisasterWord(attrName, "Attr: " .. tostring(attrVal))
		end
		if typeof(attrVal) == "string" and containsDisasterKeyword(attrVal) then
			registerDisasterWord(attrVal, "AttrVal: " .. attrName)
		end
	end
end

local function scanAllDisasters()
	table.clear(CollectedDisasters)

	for _, root in ipairs(ScanRoots) do
		if root then
			inspectObjectForDisasters(root)
			for _, desc in ipairs(root:GetDescendants()) do
				inspectObjectForDisasters(desc)
			end
		end
	end

	-- Quét thêm PlayerGui hiện tại (tránh quét nhầm menu này)
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
	if playerGui then
		for _, guiObj in ipairs(playerGui:GetDescendants()) do
			if not guiObj:IsDescendantOf(ScreenGui) then
				inspectObjectForDisasters(guiObj)
			end
		end
	end
end

local function clearListRows()
	for _, child in ipairs(ListScroll:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
end

local function refreshMenuList(filterText)
	clearListRows()
	filterText = string.lower(string.match(filterText or "", "^%s*(.-)%s*$") or "")

	local sorted = {}
	for _, item in pairs(CollectedDisasters) do
		if filterText == "" or string.find(string.lower(item.name), filterText, 1, true) or string.find(string.lower(item.source), filterText, 1, true) then
			table.insert(sorted, item)
		end
	end

	table.sort(sorted, function(a, b)
		return string.lower(a.name) < string.lower(b.name)
	end)

	StatusLabel.Text = string.format(
		"Tổng hợp từ thảm họa: %d / %d từ | Neon Purple Active",
		#sorted,
		(function()
			local c = 0
			for _ in pairs(CollectedDisasters) do c += 1 end
			return c
		end)()
	)

	if #sorted == 0 then
		local emptyCard = newInstance("Frame", {
			Name = "000_Empty",
			Size = UDim2.new(1, 0, 0, 54),
			BackgroundColor3 = Theme.BgCard
		}, ListScroll)
		addCorner(emptyCard, 8)
		addStroke(emptyCard, Theme.NeonMain, 1, 0.45)

		newInstance("TextLabel", {
			Size = UDim2.new(1, -16, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			BackgroundTransparency = 1,
			Text = "Chưa phát hiện từ thảm họa khớp. Thử bấm [↻ Quét lại] khi round/event bắt đầu!",
			TextColor3 = Theme.TextDim,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextWrapped = true
		}, emptyCard)
		return
	end

	for idx, entry in ipairs(sorted) do
		local row = newInstance("Frame", {
			Name = string.format("%04d_%s", idx, entry.name),
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = Theme.BgCard
		}, ListScroll)
		addCorner(row, 8)
		local rowStroke = addStroke(row, Theme.NeonMain, 1.1, 0.35)

		newInstance("TextLabel", {
			Size = UDim2.new(0, 28, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			BackgroundTransparency = 1,
			Text = "#" .. tostring(idx),
			TextColor3 = Theme.NeonBright,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left
		}, row)

		newInstance("TextLabel", {
			Size = UDim2.new(1, -148, 0, 20),
			Position = UDim2.new(0, 36, 0, 3),
			BackgroundTransparency = 1,
			Text = entry.name,
			TextColor3 = Theme.TextMain,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd
		}, row)

		newInstance("TextLabel", {
			Size = UDim2.new(1, -148, 0, 16),
			Position = UDim2.new(0, 36, 0, 22),
			BackgroundTransparency = 1,
			Text = string.format("Nguồn: %s • Xuất hiện: %d", entry.source, entry.count),
			TextColor3 = Theme.TextDim,
			Font = Enum.Font.Gotham,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd
		}, row)

		local copyBtn = newInstance("TextButton", {
			Size = UDim2.new(0, 96, 0, 26),
			Position = UDim2.new(1, -106, 0.5, -13),
			BackgroundColor3 = Theme.NeonDeep,
			Text = "Copy Từ",
			TextColor3 = Theme.TextMain,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			AutoButtonColor = false
		}, row)
		addCorner(copyBtn, 6)
		addStroke(copyBtn, Theme.NeonBright, 1, 0.25)

		row.MouseEnter:Connect(function()
			TweenService:Create(row, TweenInfo.new(0.15), { BackgroundColor3 = Theme.BgCardHover }):Play()
			TweenService:Create(rowStroke, TweenInfo.new(0.15), { Transparency = 0.05 }):Play()
		end)

		row.MouseLeave:Connect(function()
			TweenService:Create(row, TweenInfo.new(0.15), { BackgroundColor3 = Theme.BgCard }):Play()
			TweenService:Create(rowStroke, TweenInfo.new(0.15), { Transparency = 0.35 }):Play()
		end)

		copyBtn.MouseButton1Click:Connect(function()
			if setclipboard then
				setclipboard(entry.name)
				copyBtn.Text = "✓ Đã Copy"
				task.delay(1, function()
					if copyBtn and copyBtn.Parent then
						copyBtn.Text = "Copy Từ"
					end
				end)
			else
				copyBtn.Text = "No Clipboard"
			end
		end)
	end
end

-- // SỰ KIỆN NÚT & TÌM KIẾM
local function runScanAndRender()
	scanAllDisasters()
	refreshMenuList(SearchBox.Text)
end

ScanBtn.MouseButton1Click:Connect(function()
	ScanBtn.Text = "⏳ Đang..."
	runScanAndRender()
	task.wait(0.2)
	ScanBtn.Text = "↻ Quét lại"
end)

CopyAllBtn.MouseButton1Click:Connect(function()
	local lines = {}
	for _, item in pairs(CollectedDisasters) do
		table.insert(lines, item.name)
	end
	table.sort(lines, function(a, b) return string.lower(a) < string.lower(b) end)

	if #lines > 0 and setclipboard then
		setclipboard(table.concat(lines, "\n"))
		CopyAllBtn.Text = "✓ Copied!"
	else
		CopyAllBtn.Text = "Trống/NoCB"
	end
	task.delay(1.1, function()
		if CopyAllBtn and CopyAllBtn.Parent then
			CopyAllBtn.Text = "📋 Copy List"
		end
	end)
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	refreshMenuList(SearchBox.Text)
end)

local isVisible = true
local function setMenuVisible(state)
	isVisible = state
	MainFrame.Visible = state
end

CloseBtn.MouseButton1Click:Connect(function()
	setMenuVisible(false)
end)

ToggleButton.MouseButton1Click:Connect(function()
	setMenuVisible(not isVisible)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
		setMenuVisible(not isVisible)
	end
end)

-- Tự động bắt object mới sinh ra có từ thảm họa
for _, root in ipairs(ScanRoots) do
	if root then
		root.DescendantAdded:Connect(function(desc)
			task.defer(function()
				if desc and desc.Parent then
					inspectObjectForDisasters(desc)
					if isVisible then
						refreshMenuList(SearchBox.Text)
					end
				end
			end)
		end)
	end
end

-- Chạy quét lần đầu
runScanAndRender()
