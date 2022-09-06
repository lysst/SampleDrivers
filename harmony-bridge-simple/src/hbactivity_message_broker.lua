local log = require "log"
local capabilities = require "st.capabilities"
local utils = require "st.utils"
local json = require "dkjson"

local hbactivity_message_broker = {}

function hbactivity_message_broker.messageReceived(driver,device,msg)
    if msg.type == "connect.stateDigest?notify" then
        hbactivity_message_broker.activityMessageReceived(driver,device,msg)
    end
    if msg.type == "harmony.engine?startActivityFinished" then
       hbactivity_message_broker.activityMessageReceived(driver,device,msg)
    end
end
function hbactivity_message_broker.activityMessageReceived(driver,device,msg)
    log.info("Activity Message Broker - Received: ",utils.stringify_table(msg,"Activity Message: ",true))
    local deviceList = driver:get_devices()
    log.info(utils.stringify_table(utils.stringify_table(deviceList,"device: ",true), "Devices: ", true))
    local activityList = device:get_field("activityList")
    log.info(utils.stringify_table(utils.stringify_table(activityList,"activities: ",true), "Devices: ", true))
end


return hbactivity_message_broker