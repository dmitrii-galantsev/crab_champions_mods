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
                --v.Crystals = v.Crystals * 10 + 10000;
                if v.ScaleMultiplier then
                    v.ScaleMultiplier = v.ScaleMultiplier * 0.5;
                end
                print(string.format("crab %s has %s crystals", i, v.Crystals));
            end
        end

    end)
end

function MyGiveMult()

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
    ExecuteWithDelay(1000, function()
        local CrabPlayerC = FindAllOf("CrabPlayerC");
        if not CrabPlayerC then
            print("No CrabPlayerC Found");
            return;
        end
        ---@param v ACrabPlayerC
        for i, v in ipairs(CrabPlayerC)  do
            v.bIsBananaActive = true;
            print(string.format("crab: %s banana? %s", i, v.bIsBananaActive ))
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
function NoBananaDuel()
    ExecuteWithDelay(1000, function()
        local CrabPlayerC = FindAllOf("CrabPlayerC");
        if not CrabPlayerC then
            print("No CrabPlayerC Found");
            return;
        end
        ---@param v ACrabPlayerC
        for i, v in ipairs(CrabPlayerC)  do
            v.bIsBananaActive = false;
            print(string.format("crab: %s banana? %s", i, v.bIsBananaActive ))
        end
    end)
end

function is_null(arg)
    if not UKismetSystemLibrary:IsValid(arg) then
        print("arg is invalid")
    else
        print("arg is valid")
    end
end

function IterateWeaponMods(outer_array)
    -- Iterate over the outer array
    local inner_array = outer_array

    -- Iterate over the inner array of FCrabWeaponMod
    for j = 1, inner_array:Num() do
        local weapon_mod = inner_array:Get(j)

        -- Now you can access FCrabWeaponMod properties
        local weapon_mod_da = weapon_mod.WeaponModDA
        local inventory_info = weapon_mod.InventoryInfo

        -- Example of accessing nested properties
        if weapon_mod_da then
            local name = weapon_mod_da.Name
            local description = weapon_mod_da.Description
            local rarity = weapon_mod_da.Rarity
            -- ... process the weapon mod data
            print(string.format("w name: %s", name));
        end
    end
end

function MyTest()
    ExecuteWithDelay(1000, function()
        --local crabpc = FindAllOf("CrabPC");
        --if not crabpc then
        --    print("No crabpc Found");
        --    return;
        --end
        --for i, v in ipairs(crabpc)  do
        --    ExecuteInGameThread(function()
        --        v.ClientRefreshPSUI();
        --        v.ClientOnReceivedChatMessage("Boss", "uwu");
        --        --v.ClientOnPickedUpPickup
        --    end)
        --end

        local crabps = FindAllOf("CrabPS");
        if not crabps then
            print("No wow Found");
            return;
        end
        print("wow found crabps");
        ---@param v ACrabPS
        for i, v in ipairs(crabps)  do
            print(string.format("WM[%s] AM[%s] MM[%s] P[%s] R[%s]",
            v.WeaponMods:GetArrayNum(),
            v.AbilityMods:GetArrayNum(),
            v.MeleeMods:GetArrayNum(),
            v.Perks:GetArrayNum(),
            v.Relics:GetArrayNum()));

            v.WeaponMods:ForEach(function(index, m)
                ---@type FCrabWeaponMod
                local mod = m:get();
                mod.InventoryInfo.Level = mod.InventoryInfo.Level * 2 + 1;
                print(string.format("WM: %s %d", mod.WeaponModDA.Name:ToString(), mod.InventoryInfo.Level))
            end)
            v.AbilityMods:ForEach(function(index, m)
                ---@type FCrabAbilityMod
                local mod = m:get();
                mod.InventoryInfo.Level = mod.InventoryInfo.Level * 2 + 1;
                print(string.format("AM: %s %d", mod.AbilityModDA.Name:ToString(), mod.InventoryInfo.Level))
            end)
            v.MeleeMods:ForEach(function(index, m)
                ---@type FCrabMeleeMod
                local mod = m:get();
                mod.InventoryInfo.Level = mod.InventoryInfo.Level * 2 + 1;
                print(string.format("MM: %s %d", mod.MeleeModDA.Name:ToString(), mod.InventoryInfo.Level))
            end)
            v.Perks:ForEach(function(index, m)
                ---@type FCrabPerk
                local mod = m:get();
                mod.InventoryInfo.Level = mod.InventoryInfo.Level / 2 + 1;
                print(string.format("P: %s %d", mod.PerkDA.Name:ToString(), mod.InventoryInfo.Level))
            end)
            v.Relics:ForEach(function(index, m)
                ---@type FCrabRelic
                local mod = m:get();
                mod.InventoryInfo.Level = mod.InventoryInfo.Level * 2 + 1;
                print(string.format("R: %s %d", mod.RelicDA.Name:ToString(), mod.InventoryInfo.Level))
            end)
        end
    end)
end

function MyTest2()
    ExecuteWithDelay(1000, function()
        local wow = FindAllOf("CrabPS");
        if not wow then
            print("No wow Found");
            return;
        end
        ---@param v ACrabPlayerC
        for i, v in ipairs(wow)  do
            --v.ScaleMultiplier = 1.0 + v.ScaleMultiplier * 0.0005;
            v.ScaleMultiplier = 1.0 + v.ScaleMultiplier * 1.5;
            --v.ChanceToSpawnRandomPickup = v.ChanceToSpawnRandomPickup * 2 + 1;
            --v.bIgnoreCharacterCollision = not v.bIgnoreCharacterCollision;
            --v.bCanLeak = not v.bCanLeak;
            print(string.format("crab: %s", i));
            print(string.format(" [ScaleMultiplier] %s", v.ScaleMultiplier ))
            --print(string.format(" [bIgnoreCharacterCollision] %s", v.bIgnoreCharacterCollision ))
        end
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
    print("[MyLuaMod] MyTest\n")
    ExecuteInGameThread(function()
        MyTest()
    end)
end)

RegisterKeyBind(Key.F2, {}, function()
    print("[MyLuaMod] MyTest2\n")
    ExecuteInGameThread(function()
        MyTest2()
    end)
end)

RegisterKeyBind(Key.F4, {}, function()
    print("[MyLuaMod] Toggle BananaMode\n")
    if banana_is_reg == false then
        CrabPCClientOnEliminatedpreID, CrabPCClientOnEliminatedpostID = RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEliminated", BananaDuel);
        banana_is_reg = true;
        ExecuteInGameThread(function()
            BananaDuel()
        end)
    else
        UnregisterHook("/Script/CrabChampions.CrabPC:ClientOnEliminated", CrabPCClientOnEliminatedpreID, CrabPCClientOnEliminatedpostID);
        banana_is_reg = false;
        ExecuteInGameThread(function()
            NoBananaDuel()
        end)
    end
end)


RegisterKeyBind(Key.F6, {}, function()
    print("[MyLuaMod] Disable Banana mode\n")
    ExecuteInGameThread(function()
        NoBananaDuel()
    end)
end)
