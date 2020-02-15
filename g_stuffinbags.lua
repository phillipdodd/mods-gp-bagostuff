--* Globals

Bags = {}
Bags["pd.item.bagobugs"]        = "smallinsects"
Bags["pd.item.bagocoal"]        = "coal"
Bags["pd.item.bagofeathers"]    = "feather"
Bags["pd.item.bagofur"]         = "delicatefur"
Bags["pd.item.bagogoldenpoo"]   = "goldenpoop"
Bags["pd.item.bagopoo"]         = "poop"
Bags["pd.item.bagowool"]        = "wool"
Bags["pd.item.jarohoney"]       = "honey"

function OnTemplate()
    self.RegisterListener(Messager.UsableStarted, ApplyUsableListeners)
    self.RegisterListener(Messager.UsableEnded, UsableEnded)
end

function ApplyUsableListeners(itemID)
    local listener = CreateListenerForBag(itemID)
    if listener then
        self.RegisterListener(Messager.UsableInteract, listener)
    end
end

function CreateListenerForBag(itemID)
    local bag = Bags[itemID]
    local amount = 50
    if bag ~= nil then
        return function()
            local pos = World.GetPositionNearToPlayer(1, true)
            World.DropItem(bag, amount, pos)
            self.ConsumeUsable()
        end
    end
end

function UsableEnded()
    self.UnregisterListener(Messager.UsableInteract)
end
