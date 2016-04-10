local tweetVal, tweetEvent = ...
print('tweetVal = ' .. tweetVal)
print('tweetEvent = ' .. tweetEvent)
valueString = "\"value1\":" .. tweetVal
valueString = "{" .. valueString .. "}"
print(valueString)
intStringLength = string.len(valueString)

if wifi.sta.status() == 5 then
    gpio.write(2,gpio.HIGH)
    tmr.delay(3 * 1000 * 1000)
    gpio.write(2,gpio.LOW)
    print('Wifi ok ' .. wifi.sta.getip())

    moist = dofile('readmoist.lua') -- get moist reading
    makerChannelKey = dofile("makerchannelkey.lua") -- get makerchannel key
    gpio.write(2,gpio.HIGH)
    tmr.delay(1 * 500 * 1000)
    gpio.write(2,gpio.LOW)
    print('Makerchannel key loaded ' .. tostring(makerChannelKey))
    
    conn = nil
    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(call, payload)
                        print('payload: ' .. tostring(payload))
                        end)
    conn:on("connection", function(call, payload)
        print('Connected')
        call:send("POST /trigger/" .. tweetEvent .. "/with/key/" .. makerChannelKey .. " HTTP/1.1\r\n" ..
                    "Host: maker.ifttt.com\r\n" ..
                    "Accept: */*\r\n" ..
                    "Content-Type: application/json\r\n" ..
                    "Content-Length: " .. intStringLength .. "\r\n\r\n" .. valueString .. "\r\n"
        ) end)
        --conn:send("POST /trigger/" .. tweetEvent .. "/with/key/oTS9rXKLzheS0YN78Hlcg5MQYvEfFwDcFS8hXvjB2t6 HTTP/1.1\r\n")
        --conn:send("Host: maker.ifttt.com\r\n") 
        --conn:send("Accept: */*\r\n") 
        --conn:send("Content-Type: application/json\r\n")
        --conn:send("Content-Length: " .. intStringLength .. "\r\n\r\n" .. valueString .. "\r\n")

    conn:on("disconnection", function(conn, payload) print('Disconnected') end)
    
    conn:connect(80,"maker.ifttt.com")
    print('tweeting!')
else
    gpio.write(3,gpio.HIGH)
    tmr.delay(3 * 1000 * 1000)
    gpio.write(3,gpio.LOW)
    dofile('wifi.lua')
end
