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
    local device_list = driver:get_devices()
    for _, d in ipairs(device_list) do
        log.info("DeviceID: ",d.id)
        log.info("Device Parent: ",d.parent_device_id)
        log.info("Device Activity:",d.vendor_provided_label)
    end
end


return hbactivity_message_broker