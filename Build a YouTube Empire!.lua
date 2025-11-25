local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SLEEP HUB",
   Icon = 121030902371363, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "SLEEP HUB",
   LoadingSubtitle = "by SLEEP HUB",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Dark Blue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "Q", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "SLEEP HUB Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "SLEEP", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"SLEEP"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("หน้าหลัก", 134685084741535)


--------------------------------------------------------------------
-- ตัวแปรไว้เช็กสถานะ
--------------------------------------------------------------------
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerName = "Zoogo10015"
local event = ReplicatedStorage:WaitForChild("events"):WaitForChild("selfRecord")

local connection = nil   -- เก็บ RenderStep ไว้เช็ก/ตัดการทำงาน
--------------------------------------------------------------------
-- สร้าง Toggle บน Tab ของคุณ
--------------------------------------------------------------------
local Toggle = Tab:CreateToggle({
    Name        = "Auto-Fire Every 0.01s",
    CurrentValue = false,
    Flag        = "Toggle1",

    Callback = function(Value)
        -- ถ้าเปิด
        if Value then
            -- ถ้ายังไม่มี connection ให้สร้างใหม่
            if not connection then
                connection = RunService.RenderStepped:Connect(function()
                    -- ยิงทุกเฟรม (≈ 0.01 วินาที)
                    local target = game:GetService("Players"):FindFirstChild(playerName)
                    if target then
                        event:FireServer(target)
                    end
                end)
            end
        else
            -- ถ้าปิด ให้ตัดการเชื่อมต่อ
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end,
})



local Button = Tab:CreateButton({
   Name = "Button Example",
   Callback = function()
   game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("uploadAll"):FireServer()

   end,
})

local Button = Tab:CreateButton({
   Name = "Button Example",
   Callback = function()
   game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("claimAll"):FireServer()

   end,
})

Rayfield:LoadConfiguration()