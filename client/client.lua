Main = {job=nil}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    Wrapper:Target2('pool_startnpc',Config.Lang.Start,Config.Lang.Stop,Config.Settings.StartPos,'bbv-poolcleaner:startjob','bbv-poolcleaner:stopjob')
    Wrapper:Blip('pool_startnpcblip','Pool Cleaner', Config.Settings.StartPos,181,5,0.5)
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wrapper:Target2('pool_startnpc',Config.Lang.Start,Config.Lang.Stop,Config.Settings.StartPos,'bbv-poolcleaner:startjob','bbv-poolcleaner:stopjob')
    Wrapper:Blip('pool_startnpcblip','Pool Cleaner', Config.Settings.StartPos,181,5,0.5)
end)

CreateThread(function()
    Wrapper:Target2('pool_startnpc',Config.Lang.Start,Config.Lang.Stop,Config.Settings.StartPos,'bbv-poolcleaner:startjob','bbv-poolcleaner:stopjob')
    Wrapper:Blip('pool_startnpcblip','Pool Cleaner', Config.Settings.StartPos,181,5,0.5)
end)

RegisterNetEvent('bbv-poolcleaner:startjob', function()
    if Main.job ~= nil then 
        Wrapper:Notify(Config.Lang.AlreadyWorking, 'error', 2500)
        return
    end
    Main.job = math.random(1,#Config.Locations)
    Wrapper:Notify(Config.Lang.Started,'success',2500)
    Main:StartJob(job)
end)

RegisterNetEvent('bbv-poolcleaner:stopjob', function()
    if Main.job == nil then 
        Wrapper:Notify(Config.Lang.NotWorking, 'error', 2500)
        return
    end
    Main.job = nil
    currid = nil
    TriggerEvent('Wrapper:Reset')
    Wrapper:Notify(Config.Lang.Stoped,'error',2500)
    -- Main:StartJob(job)
end)

function Main:StartJob()
    self:CreateWork()
end

function Main:CreateWork(job)
    for k,v in pairs(Config.Locations[self.job].Work) do
        self:CleanBuild(Config.Locations[self.job].Work[k],k)
        --print(Config.Locations[self.job].Work[k],k)
    end
    for k,v in pairs(Config.Locations) do
        -- self:CleanBuild()
    end
end

function Main:CleanBuild(pos,id)
    local currid = id
    -- Wrapper:Blip('pool_clean_main'..self.job..currid,'Pool Clean - '..currid,pos,270,1,0.6)
    Wrapper:Blip('pool_clean'..self.job..currid,'Pool Clean - '..currid,pos,270,1,0.6)
    Wrapper:CreateObject('pool_prop'..self.job..currid,Config.Settings.Trash,pos,true,false)
    Wrapper:Target('pool_target'..self.job..currid,Config.Lang.Clean,pos,'bbv-poolclean'..currid)


    RegisterNetEvent('bbv-poolclean'..currid,function()
        if Main.job == nil then 
            return
        end
        if self.busy then 
            Wrapper:Notify(Config.Lang.DoingSomething,'error',2500)
            return 
        end
        self.busy = true
        --print(Main.job.. ' '.. Main.currid)
    
        local ad = "anim@amb@drug_field_workers@rake@male_a@base"
        local anim = 'base'
        local player = PlayerPedId()
        local pcoords = GetEntityCoords(player)
    
        if (DoesEntityExist(player) and not IsEntityDead(player)) then
            Main:LoadAnim(ad)
            TaskPlayAnim(player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
            
            broom = CreateObject(Config.Settings.Broom.Name, pcoords.x, pcoords.y, pcoords.z, false, false, false)
    
            SetEntityCollision(broom, false, false)
            AttachEntityToEntity(broom, player, GetPedBoneIndex(player, Config.Settings.Broom.Bone), Config.Settings.Broom.Placement[1].x, Config.Settings.Broom.Placement[1].y, Config.Settings.Broom.Placement[1].z, Config.Settings.Broom.Placement[2].x, Config.Settings.Broom.Placement[2].y, Config.Settings.Broom.Placement[2].z, true, true, false, true, 1, true)
            
            SetModelAsNoLongerNeeded(Config.Settings.Broom.Name)
    
        end
        Wait(Config.Settings.CleanTime)
        if (IsEntityPlayingAnim(player, ad, anim, 3)) then 
            TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
            ClearPedSecondaryTask(player)
            DeleteObject(broom)
    
            Wrapper:TargetRemove('pool_target'..self.job..currid)
            Wrapper:DeleteObject('pool_prop'..self.job..currid)
            Wrapper:RemoveBlip('pool_clean'..self.job..currid)
            Wrapper:AddMoney(Config.Settings.SalaryType,Config.Settings.Salary)
            Wrapper:Notify(Config.Lang.Reward .. ' ' ..Config.Settings.Salary .. '$','success',2500)
            self.busy = false
        end
    end)    

end

function Main:LoadAnim(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end