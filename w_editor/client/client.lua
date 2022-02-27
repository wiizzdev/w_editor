    -- G_Corporation -- wiizz -- 
  -- https://github.com/wiizzdev --
 -- https://discord.gg/VpYP58ZjmD --

local mainMenu = RageUI.CreateMenu("Editeur Rockstar", "MENU")
local confirmation = RageUI.CreateSubMenu(mainMenu, "Confirmation", "MENU")
local open = false

mainMenu.Closed = function() open = false end

function Editeur()
    if open then 
        open = false 
            RageUI.Visible(mainMenu, false) 
        return 
    else 
        open = true 
            RageUI.Visible(mainMenu, true)
            CreateThread(function()
                while open do 
                    RageUI.IsVisible(mainMenu, function()
                        RageUI.Button("Lancer l'Éditeur Rockstar", nil, {RightLabel = "→"}, true, {}, confirmation)
                        if not (IsRecording()) then
                            RageUI.Button("Lancer l'Enregistrement", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    StartRecording(1)
                                end
                            })
                        else
                            RageUI.Button("Lancer l'Enregistrement", "~r~Vous êtes déjà en enregistrement", {}, false, {})
                        end
                        if(IsRecording()) then
                            RageUI.Button("Arrêter l'Enregistrement", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    StopRecordingAndSaveClip()
                                end
                            })
                        else
                            RageUI.Button("Arrêter l'Enregistrement", "~r~Vous n'êtes pas en enregistrement", {}, false, {})
                        end
                    end)
                    RageUI.IsVisible(confirmation, function()
                        RageUI.Separator("↓ Êtes vous sur ? ↓")
                        RageUI.Button("Oui", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                NetworkSessionLeaveSinglePlayer()
                                ActivateRockstarEditor()
                            end
                        })
                        RageUI.Button("Non", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                RageUI.GoBack()
                            end
                        })
                    end)
                Wait(0)
            end
        end)
    end
end

RegisterCommand("editor", function()
    Editeur()
end)
