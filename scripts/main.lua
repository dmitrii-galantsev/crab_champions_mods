local UEHelpers = require("UEHelpers")

print("[MyLuaMod] Mod loaded\n")

local lastLocation = nil
local banana_is_reg = false
local no_banana_is_reg = false

function MakePause()
    local FirstPlayerController = UEHelpers:GetPlayerController()
    if not FirstPlayerController or not FirstPlayerController:IsValid() then
        print("[MyLuaMod] Failed to find PlayerController\n")
        return
    end

    local Pawn = FirstPlayerController.Pawn
    if not Pawn or not Pawn:IsValid() then
        print("[MyLuaMod] Failed to find Pawn\n")
        return
    end

    FirstPlayerController.ServerPause()
end

function MyGiveMoney()
    return;
    print("Starting LoopChests");

    ExecuteWithDelay(1000, function()
        local CrabPS = FindAllOf("CrabPS");
        if not CrabPS then
            print("No CrabPS Found");
            return;
        else
            print("Found CrabPS with " .. #CrabPS .. " entries");
            ---@param v ACrabPS
            for i, v in ipairs(CrabPS)  do
                v.Crystals = v.Crystals * 10 + 10000;
                if v.ScaleMultiplier then
                    v.ScaleMultiplier = v.ScaleMultiplier * 10;
                end
                print(string.format("crab %s has %s crystals", i, v.Crystals));
            end
        end

    end)
end

function MyGiveMult()
    return;

    print("Starting MyGiveMult");
    ExecuteWithDelay(1000, function()
        local CrabPS = FindAllOf("CrabPS");
        if not CrabPS then
            print("No CrabPS Found");
            return;
        else
            ---@param v ACrabPS
            for i, v in ipairs(CrabPS)  do
                v.DamageMultiplier = v.DamageMultiplier * 1.1;
                print(string.format("crab %s has %s DamageMultiplier", i, v.DamageMultiplier));
            end
        end

    end)
end

---@param CRAB ACrabPC
---@param nim any
---@param convert_all_to_duel bool
function BananaDuel(convert_all_to_duel)
    ExecuteWithDelay(500, function()
        local CrabPlayerC = FindAllOf("CrabPlayerC");
        if not CrabPlayerC then
            print("No CrabPlayerC Found");
            return;
        end
        ---@param v ACrabPlayerC
        for i, v in ipairs(CrabPlayerC)  do
            v.bIsBananaActive = true;
            print(string.format("crab: %s", i));
            print(string.format(" [bIsBananaActive] %s", v.bIsBananaActive ))
        end
        --if convert_all_to_duel then
        --    local CrabPortal = FindAllOf("CrabPortal");
        --    if not CrabPortal then
        --        print("No CrabPortal Found");
        --        return;
        --    end
        --    for i, v in ipairs(CrabPortal) do
        --        print(string.format("portal.IslandType %s", v.IslandType))
        --        v.IslandType = 18; -- 18 is duel
        --    end
        --end
    end)
end

---@param CRAB ACrabPC
---@param nim any
---@param convert_all_to_duel bool
function NoBananaDuel(convert_all_to_duel)
    ExecuteWithDelay(1000, function()
        local CrabPlayerC = FindAllOf("CrabPlayerC");
        if not CrabPlayerC then
            print("No CrabPlayerC Found");
            return;
        end
        ---@param v ACrabPlayerC
        for i, v in ipairs(CrabPlayerC)  do
            v.bIsBananaActive = false;
            print(string.format("crab: %s", i));
            print(string.format(" [bIsBananaActive] %s", v.bIsBananaActive ))
        end
        --if convert_all_to_duel then
        --    local CrabPortal = FindAllOf("CrabPortal");
        --    if not CrabPortal then
        --        print("No CrabPortal Found");
        --        return;
        --    end
        --    for i, v in ipairs(CrabPortal) do
        --        print(string.format("portal.IslandType %s", v.IslandType))
        --        v.IslandType = 18; -- 18 is duel
        --    end
        --end
    end)
end

function MyListTotems()
    ExecuteWithDelay(1000, function()
    local CrabTotem = FindAllOf("CrabTotem");
        if not CrabTotem then
            print("No CrabTotem Found");
            return;
        end
        for i, v in ipairs(CrabTotem) do
            print(string.format("totem: %s", i));
            print(string.format("[kaboom chance: %s]", v.ChanceToExplode));
            print(string.format("[bIsExploded: %s]", v.bIsExploded));
            print(string.format("[NumBuffs: %s]", v.NumBuffs))
            --print(string.format("[Cost: %s]", v.Cost ? v.Cost : 0))
        end
    end)
end

RegisterKeyBind(Key.F1, {}, function()
    print("[MyLuaMod] Key pressed\n")
    ExecuteInGameThread(function()
        MyListTotems()
    end)
end)

RegisterKeyBind(Key.F2, {}, function()
    print("[MyLuaMod] Key pressed\n")
    ExecuteInGameThread(function()
        MakePause()
    end)
end)

RegisterKeyBind(Key.F3, {}, function()
    print("[MyLuaMod] Key pressed MONEYyYYyY\n")
    ExecuteInGameThread(function()
        MyGiveMoney()
    end)
end)

RegisterKeyBind(Key.F4, {}, function()
    print("[MyLuaMod] Key pressed TIME TO SLIDE\n")
    --if banana_is_reg == false then
    --    RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEliminated", BananaDuel);
    --    banana_is_reg = true;
    --end
    ExecuteInGameThread(function()
        BananaDuel(nil)
    end)
end)

RegisterKeyBind(Key.F5, {}, function()
    print("[MyLuaMod] Key pressed increasing dmg mult\n")
    ExecuteInGameThread(function()
        MyGiveMult()
    end)
end)


RegisterKeyBind(Key.F6, {}, function()
    print("[MyLuaMod] Key pressed increasing dmg mult\n")
    --if no_banana_is_reg == false then
    --    RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEliminated", NoBananaDuel);
    --    no_banana_is_reg = true;
    --end
    ExecuteInGameThread(function()
        NoBananaDuel()
    end)
end)
