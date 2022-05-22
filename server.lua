local dutyPlayers = {}

RegisterNetEvent('rc-duty:checkduty', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pJob = GetResourceKvpString('lastJob:' .. xPlayer.identifier)
    if pJob then
        pJob = json.decode(pJob)
        xPlayer.setJob(pJob.lastJob, pJob.lastJobGrade)
        SetResourceKvp('lastJob:' .. xPlayer.identifier, nil)
    end
end)

RegisterNetEvent('rc-duty:changeduty', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not Config.jobs[xPlayer.job.name] and xPlayer.job.name ~= 'offduty' then return end
    if not dutyPlayers[_source] then
        dutyPlayers[_source] = {
            lastJob = xPlayer.job.name,
            lastJobGrade = xPlayer.job.grade,
            identifier = xPlayer.identifier
        }
        xPlayer.setJob('offduty', 0)
    else
        Wait(100)
        xPlayer.setJob(dutyPlayers[_source].lastJob, dutyPlayers[_source].lastJobGrade)
        Wait(10)
        dutyPlayers[_source] = nil
    end
end)

AddEventHandler('playerDropped', function()
    local _source <const> = source
    if dutyPlayers[_source] then
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer then
            xPlayer.setJob(dutyPlayers[_source].lastJob, dutyPlayers[_source].lastJobGrade)  
            dutyPlayers[_source] = nil
        else
            -- just incase jei darbo neuzdetu
            local pJob = dutyPlayers[_source]
            SetResourceKvp('lastJob:'..pJob.identifier, tostring(json.encode(pJob)))
        end   
    end
end)
  
  
