Config = {}
Config.Debug = true

QBCore = exports['qb-core']:GetCoreObject() -- DELETE IF YOU USE ESX
-- ESX = exports["es_extended"]:getSharedObject() -- UNCOMMENT IF YOU USE ESX

Config.Settings = {
    Framework = 'QB', -- QB/ESX
    Target = "OX", -- OX/QB/BT
    StartPos = vector3(-850.04, -251.9, 40.05 + 1),
    Salary = 25, 
    SalaryType = 'cash',
    Trash = 'prop_rub_litter_03',
    CleanTime = 5000,
    Broom = {
        Bone = 28422,
        Name = 'prop_tool_broom',
        Placement = {
            vector3(-0.010000, 0.040000, -0.030000),
            vector3(0.000000, 0.000000, 0.000000),
        },
    },
}

Config.Locations = {
    [1] = {
        Blip = vector3(-898.14, 174.3, 69.44),
        Work = {
            vector3(-889.09, 172.03, 69.44),
            vector3(-906.48, 167.9, 69.45),
            vector3(-897.82, 175.5, 69.45),
        },
    },
    [2] = {
        Blip = vector3(-894.3, -39.67, 36.98),
        Work = {
            vector3(-898.1, -44.31, 38.24),
            vector3(-891.92, -45.92, 38.25),
        },
    }
}

Config.Lang = {
    Clean = "Clean up",
    DoingSomething = "You are already doing something",
    Start = "Start working",
    Started = "You started working, Locations are marked on your GPS",
    Stop = "Stop working",
    Stoped = "You stoped working",
    AlreadyWorking = 'You are already working',
    NotWorking = 'You are not working here',
    Reward = 'You got '
}

