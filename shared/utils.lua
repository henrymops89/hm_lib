-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Shared Utilities
-- ══════════════════════════════════════════════════════════════════

Utils = {}

--- Format Currency
--- @param amount number
--- @param currency symbol (e.g. '$')
function Utils.FormatCurrency(amount, symbol)
    local symbol = symbol or '$'
    local formatted = tostring(math.floor(amount))
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if k == 0 then break end
    end
    return symbol .. formatted
end

--- Get Distance between two coords
--- @param coords1 vector3
--- @param coords2 vector3
function Utils.GetDistance(coords1, coords2)
    return #(vector3(coords1.x, coords1.y, coords1.z) - vector3(coords2.x, coords2.y, coords2.z))
end

--- Deep Copy table
--- @param obj table
function Utils.DeepCopy(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[Utils.DeepCopy(k)] = Utils.DeepCopy(v) end
    return res
end

exports('FormatCurrency', Utils.FormatCurrency)
exports('GetDistance',     Utils.GetDistance)
exports('DeepCopy',        Utils.DeepCopy)
