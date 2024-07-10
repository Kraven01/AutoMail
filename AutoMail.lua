local recipient = ""

-- Function to send mail and reset the state
local function sendMail()
    if recipient ~= "" then
        SendMail(recipient, "AutoMail", "")
        ClearSendMail()
    end
end

-- Hook to the SendMailFrame
local function onMailItemAdded()
    local numAttachments = 0
    for i = 1, ATTACHMENTS_MAX_SEND do
        if GetSendMailItem(i) then
            numAttachments = numAttachments + 1
        end
    end

    if numAttachments >= ATTACHMENTS_MAX_SEND then
        recipient = SendMailNameEditBox:GetText()
        sendMail()
        
        C_Timer.After(0.3, function()
            SendMailNameEditBox:SetText(recipient)
        end)
    end
end

-- Event handler for opening the mail frame
local function onMailShow()
    recipient = ""
    hooksecurefunc("SendMailFrame_CanSend", onMailItemAdded)
end

-- Event frame to handle opening the mail frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MAIL_SHOW")
eventFrame:SetScript("OnEvent", onMailShow)
print("Automail loaded.")