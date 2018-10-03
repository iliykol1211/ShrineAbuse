local AbuseItem = {}
AbuseItem.TrigerActiv = Menu.AddOption({"Utility", "AbuseItem"}, "Shrine Abuse", "")

function AbuseItem.OnUpdate()
    if not Menu.IsEnabled(AbuseItem.TrigerActiv) then return end
        if Heroes.GetLocal() and Engine.IsInGame() then
        local mod = NPC.HasModifier(Heroes.GetLocal(), "modifier_filler_heal")
        if not mod then
            AbuseItem.triger = 0 
            AbuseItem.timer = 0
        end
        if mod and AbuseItem.timer < GameRules.GetGameTime() and AbuseItem.triger == 0 then
            for i = 0, 2 do
                local item = NPC.GetItemByIndex(Heroes.GetLocal(), i)
                if item and Abilities.Contains(item) and Ability.IsItem(item) then
                    AbuseItem.ItemStashAbuse(item, 6 + i)
                end
            end
            AbuseItem.triger = 1
            AbuseItem.timer = GameRules.GetGameTime() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.MAX_FLOWS)
        end
        if AbuseItem.triger == 1 and AbuseItem.timer < GameRules.GetGameTime() then
            for i = 6, 9 do
                local item = NPC.GetItemByIndex(Heroes.GetLocal(), i)
                if item and Abilities.Contains(item) and Ability.IsItem(item) then
                    AbuseItem.ItemStashAbuse(item, (-6 + i))
                end
            end
            AbuseItem.triger = 2
            AbuseItem.timer = GameRules.GetGameTime() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.MAX_FLOWS)
        end
        if AbuseItem.triger == 2 and AbuseItem.timer < GameRules.GetGameTime() then
            for i = 3, 6 do
                local item = NPC.GetItemByIndex(Heroes.GetLocal(), i)
                if item and Abilities.Contains(item) and Ability.IsItem(item) then
                    AbuseItem.ItemStashAbuse(item, 6 + (-3 + i))
                end
            end
            AbuseItem.triger = 3
            AbuseItem.timer = GameRules.GetGameTime() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.MAX_FLOWS)
        end
        if AbuseItem.triger == 3 and AbuseItem.timer < GameRules.GetGameTime() then
            for i = 6, 9 do
                local item = NPC.GetItemByIndex(Heroes.GetLocal(), i)
                if item and Abilities.Contains(item) and Ability.IsItem(item) then
                    AbuseItem.ItemStashAbuse(item, 3 + (-6 + i))
                end
            end
            AbuseItem.triger = 4
            AbuseItem.timer = GameRules.GetGameTime() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.MAX_FLOWS)
        end
    end
end

function AbuseItem.ItemStashAbuse(item,slot)
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_ITEM, slot, Vector(0, 0, 0), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY,Heroes.GetLocal())
end

function AbuseItem.init()
    AbuseItem.triger = 0 
    AbuseItem.timer = 0
end

function AbuseItem.OnGameStart()
AbuseItem.init()
end

function AbuseItem.OnGameEnd()
AbuseItem.init()        
end
AbuseItem.init()

return AbuseItem