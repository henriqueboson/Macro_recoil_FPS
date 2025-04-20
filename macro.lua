-- /////////// Configurações de Controle de Recuo  /////////

-- //// SMG == ARMAS COM POUCO RECUO E DISPARO RÁPIDO
-- //// AR == ARMAS COM MUITO RECUO E DISPARO MAIS LENTO

-- //// O recuo é controlado pela quantidade de pixels movidos (SMGRecoilMouseMoveAmount),
-- //// e por um atraso entre cada vez que esse movimento acontece (SMGRapidFireDelayBetweenShots)

-- //// O recuo é ativado pela tecla NumLock, e pode ser alterado nas configurações de controle. Botão 4 do mouse é o disparo rápido. É ativado ao clicar com o botão direito.

-- //// ALTERE AS INFORMAÇÕES ABAIXO --
-- //// QUANDO {SMGorARtoggle / Scrolllock por padrão} ESTÁ ATIVADO, ESTÁ USANDO CONFIGURAÇÕES DE SMG
-- //// QUANDO {SMGorARtoggle / Scrolllock por padrão} ESTÁ DESATIVADO, ESTÁ USANDO CONFIGURAÇÕES DE AR

-- //////////////////////////////////////// CONFIGURAÇÕES DE COMPENSAÇÃO DE RECUO -- ////////////////////////////////////////////////

SMGRecoilMouseMoveAmount    = 4  --           // distância que o mouse vai se mover para baixo para compensar o recuo. NÃO use decimais
ARRecoilMouseMoveAmount     = 8 --           // QUANTO MAIOR == puxa mais o mouse para baixo. 1 movimento == 100 de DelaySleep

SMGMouseMoveDelaySleep      = 4  --           // Atraso em milissegundos entre cada movimento de recuo
ARMouseMoveDelaySleep       = 4  --           // Quanto maior == menos puxada do mouse, 1 movimento == 100 de DelaySleep

HorizontalRecoilModifier    = 0  --           // -1 puxa o mouse levemente para a esquerda ao atirar, como compensação
--                                            // Se o recuo for para a direita, tente 1. 0 == sem movimento lateral

-- //////////////////////////////////////// CONFIGURAÇÕES DE DISPARO RÁPIDO -- ////////////////////////////////////////////////

SMGRapidFireDelayBetweenShots   = 80 --      // Atraso em (aproximadamente) milissegundos
ARRapidFireDelayBetweenShots    = 100 --     // entre cada movimento do mouse pelo recuo das armas SMG/AR

SMGRapidFireRecoilCompensation  = 16 --      // Entre cada disparo rápido, o mouse será puxado para baixo
ARRapidFireRecoilCompensation   = 9 --       // Quanto maior == mais puxado para baixo entre os disparos

RapidFireMousePressDurationSMG  = 9 --       // Quanto tempo o clique esquerdo será segurado no disparo rápido
RapidFireMousePressDurationAR   = 1 --       // em milissegundos. 1 == 1 clique

-- /////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////// CONTROLES -- ////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////////////////////

-- //// Opções de tecla de ativação incluem "scrolllock" "capslock" e "numlock"

LockKey = "numlock"             --    // (ATIVA/DESATIVA TODO O SCRIPT)
--                                    // Opções de tecla de ativação incluem "scrolllock" "capslock" e "numlock"

SMGorARtoggle = "scrolllock"    --    // alterna entre ARs e SMGs
--                                    //  (ou seja, entre armas com muito recuo ou pouco recuo)

RapidFireButton = "capslock" --       https://i.imgur.com/WinEVPi.png lista de botões de mouse da Logitech.
                        

-- //////////////////////////////////////// APENAS PROGRAMADORES LUA MEXAM ABAIXO -- ////////////////////////////////////////////////

RapidFireSleepMin = 0
RapidFireSleepMax = 0
MouseMove = 0
NRMin = 0
NRMax = 0
Countx = 0
CountY = 0

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////// APENAS PROGRAMADORES LUA MEXAM ABAIXO -- ////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////// ESTA SEÇÃO É (SMGorARtoggle){SE O SCROLLLOCK ESTIVER ATIVADO}  ///////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function CheckForSMGorAR()
    if IsKeyLockOn(SMGorARtoggle) then

        NoRecoilMouseMoveVert = SMGRecoilMouseMoveAmount -- Quantidade de recuo para armas automáticas. Maior valor = mais puxada para baixo

        if (SMGRapidFireDelayBetweenShots > 7) then
            RapidFireSleepMin = SMGRapidFireDelayBetweenShots - 7
            RapidFireSleepMax = SMGRapidFireDelayBetweenShots + 7
        else
            RapidFireSleepMin = SMGRapidFireDelayBetweenShots - SMGRapidFireDelayBetweenShots + 5
            RapidFireSleepMax = SMGRapidFireDelayBetweenShots + 10
        end

        MouseMove = SMGRapidFireRecoilCompensation
        SleepNoRecoilMin = SMGMouseMoveDelaySleep - 1
        SleepNoRecoilMax = SMGMouseMoveDelaySleep + 1

        -- // este if else está criando uma faixa de valores para geradores aleatórios
        if (RapidFireMousePressDurationSMG > 1) then
            PressSpeedMin = RapidFireMousePressDurationSMG - 1
            PressSpeedMax = RapidFireMousePressDurationSMG + 1
        else
            PressSpeedMin = RapidFireMousePressDurationSMG
            PressSpeedMax = RapidFireMousePressDurationSMG + 1
        end

        -- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        -- /////////////////////// ESTA PARTE É PARA ARs OU ARMAS COM MUITO RECUO. {SE O SCROLLLOCK ESTIVER DESATIVADO} ///////////////////////
        -- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    else
        NoRecoilMouseMoveVert = ARRecoilMouseMoveAmount

        SleepNoRecoilMin = ARMouseMoveDelaySleep - 1
        SleepNoRecoilMax = ARMouseMoveDelaySleep + 1

        if (ARRapidFireDelayBetweenShots > 10) then
            RapidFireSleepMin = ARRapidFireDelayBetweenShots - 5
            RapidFireSleepMax = ARRapidFireDelayBetweenShots + 5
        else
            RapidFireSleepMin = ARRapidFireDelayBetweenShots - ARRapidFireDelayBetweenShots + 5
            RapidFireSleepMax = ARRapidFireDelayBetweenShots + 5
        end

        MouseMove = ARRapidFireRecoilCompensation

        if (RapidFireMousePressDurationAR > 1) then
            PressSpeedMin = RapidFireMousePressDurationAR - 1
            PressSpeedMax = RapidFireMousePressDurationAR + 1
        else
            PressSpeedMin = RapidFireMousePressDurationAR
            PressSpeedMax = RapidFireMousePressDurationAR + 1
        end
    end
end

LC = 1 -- Altere isso   // 1 = Clique Esquerdo, 2 = Botão do meio do mouse, 3 = Clique Direito
RC = 3 -- Altere isso   // LC = Botão de Disparo, RC = Botão de Mira

function Resetter()
    Countx = 0
end

-- //////////////////////////////////////////////////////////////

function RapidFire()
    repeat
        PressMouseButton(LC)
        Sleep(math.random(PressSpeedMin, PressSpeedMax))
        ReleaseMouseButton(LC)
        Sleep(math.random(2, 4))
        MoveMouseRelative(0, MouseMove)
        Sleep(math.random(RapidFireSleepMin, RapidFireSleepMax))
    until not IsMouseButtonPressed(RC)
end

-- //////////////////////////////////////////////////////////////

function NoRecoil()
    repeat
        MoveMouseRelative(HorizontalRecoilModifier, NoRecoilMouseMoveVert)
        Sleep(math.random(SleepNoRecoilMin, SleepNoRecoilMax))
    until not IsMouseButtonPressed(LC)
end

-- //////////////////////////////////////////////////////////////

function OnEvent(event, arg)
    EnablePrimaryMouseButtonEvents(true);
    if (event == "MOUSE_BUTTON_PRESSED" and arg == LC) then
        Sleep(25)
        if IsMouseButtonPressed(RC) then
            if IsKeyLockOn(LockKey) then
                CheckForSMGorAR()
                NoRecoil()
                Resetter()
            end
        else
            while IsMouseButtonPressed(LC) do
                Sleep(15)
                if IsMouseButtonPressed(RC) then
                    CheckForSMGorAR()
                    NoRecoil()
                    Resetter()
                end
            end
        end
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == 4) then
        Sleep(25)
        if IsMouseButtonPressed(RC) then
            CheckForSMGorAR()
            RapidFire()
            Resetter()
        else
            Sleep(25)
            if IsMouseButtonPressed(RC) then
                CheckForSMGorAR()
                RapidFire()
                Resetter()
            end
        end
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == 3) then
        repeat
            if IsMouseButtonPressed(1) then
                CheckForSMGorAR()
                NoRecoil()
                Resetter()
            elseif IsMouseButtonPressed(4) then
                CheckForSMGorAR()
                RapidFire()
                Resetter()
            else
                Sleep(15)
            end
        until not IsMouseButtonPressed(3)
    end
end
