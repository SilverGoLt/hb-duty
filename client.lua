local PlayerData, PlayerLoaded, point = {}, nil, nil

--- functions

local function DrawText3D(coords, text, customEntry)
    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start)
    end

    if customEntry ~= nil then
        AddTextEntry(customEntry, str)
        BeginTextCommandDisplayHelp(customEntry)
    else
        AddTextEntry(GetCurrentResourceName(), str)
        BeginTextCommandDisplayHelp(GetCurrentResourceName())
    end
    EndTextCommandDisplayHelp(2, false, false, -1)

    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

local function CreatePoints()
    if point then return end
    if not Config.jobs[PlayerData.job.name] and PlayerData.job.name ~= 'offduty' then return end
    for k,job in pairs(Config.jobs) do
        point = lib.points.new(job.coords, job.distance, {job = k})

        function point:nearby()
            if PlayerData.job.name == self.job or PlayerData.job.name == 'offduty' then
                if PlayerData.job.name == 'offduty' then
                    DrawText3D(vec3(self.coords.x, self.coords.y, self.coords.z + 1), "~INPUT_PICKUP~ Pradeti darba")
                else
                    DrawText3D(vec3(self.coords.x, self.coords.y, self.coords.z + 1), "~INPUT_PICKUP~ Baigti darba")
                end 
                DrawMarker(job.marker.type, self.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, job.marker.size.x, job.marker.size.y, job.marker.size.z, job.marker.color.r, job.marker.color.g, job.marker.color.b, job.marker.color.a, job.marker.bob, job.marker.face, 2, nil, nil, false)
            end

            if self.currentDistance < 2.5 and IsControlJustReleased(0, 38) and (self.job == PlayerData.job.name or PlayerData.job.name == 'offduty') then
                TriggerServerEvent('rc-duty:changeduty')
            end
        end
    end
end

-- ESX events

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    PlayerData = playerData
    PlayerLoaded = true
    TriggerServerEvent('rc-duty:checkduty')
    CreatePoints()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
    CreatePoints()
end)

---