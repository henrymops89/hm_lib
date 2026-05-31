-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Webhook / Discord Bridge
-- ══════════════════════════════════════════════════════════════════

local JSON_HEADER = { ['Content-Type'] = 'application/json' }

function SendWebhook(webhook, title, description, color, fields, thumbnail, footer)
    if not webhook or webhook == '' then return false end

    local embed = {
        title       = title or 'Notification',
        description = description or '',
        color       = color or 0x00ff00,
        timestamp   = os.date('!%Y-%m-%dT%TZ'),
    }
    if footer    then embed.footer    = { text = footer }       end
    if thumbnail then embed.thumbnail = { url  = thumbnail }    end
    if fields and #fields > 0 then embed.fields = fields        end

    PerformHttpRequest(webhook, function(err, text)
        if err ~= 200 then
            print(('[hm_lib] Webhook failed (%s): %s'):format(err, text or 'unknown'))
        end
    end, 'POST', json.encode({ username = title or 'hm_lib', embeds = { embed } }), JSON_HEADER)

    return true
end

function SendDiscordLog(webhook, message, color, author)
    if not webhook or webhook == '' then return end

    local embed = {
        description = message,
        color       = color or 0x3498db,
        timestamp   = os.date('!%Y-%m-%dT%TZ'),
    }
    if author then
        embed.author = { name = author.name or '', icon_url = author.icon or '' }
    end

    PerformHttpRequest(webhook, function() end, 'POST',
        json.encode({ username = 'hm_lib Logger', embeds = { embed } }), JSON_HEADER)
end

function SendStaffAlert(webhook, rank, action, player, details)
    if not webhook or webhook == '' then return end

    local embed = {
        title       = (rank or 'Staff') .. ' Action',
        description = ('**Action:** %s\n**Player:** %s\n**Details:** %s')
                        :format(action, player, details or 'None'),
        color       = 0xe74c3c,
        timestamp   = os.date('!%Y-%m-%dT%TZ'),
    }

    PerformHttpRequest(webhook, function() end, 'POST',
        json.encode({ username = 'Staff Alert', embeds = { embed } }), JSON_HEADER)
end

exports('SendWebhook',    SendWebhook)
exports('SendDiscordLog', SendDiscordLog)
exports('SendStaffAlert', SendStaffAlert)
