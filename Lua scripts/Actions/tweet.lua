local tweetVal, tweetEvent = ...
print('tweetVal = ' .. tweetVal)
print('tweetEvent = ' .. tweetEvent)
valueString = "\"value1\":" .. tweetVal
valueString = "{" .. valueString .. "}"
print(valueString)
intStringLength = string.len(valueString)

if wifi.sta.status() == 5 then
    gpio.write(2,gpio.HIGH)
    tmr.delay(2000000)
    gpio.write(2,gpio.LOW)
    print('Wifi ready')
    
    conn = nil
    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) end)
    conn:connect(80,"maker.ifttt.com")
    conn:on("connection", function(conn, payload)
    conn:send("POST /trigger/" .. tweetEvent .. "/with/key/oTS9rXKLzheS0YN78Hlcg5MQYvEfFwDcFS8hXvjB2t6 HTTP/1.1\r\n")
    conn:send("Host: maker.ifttt.com\r\n") 
    conn:send("Accept: */*\r\n") 
    conn:send("Content-Type: application/json\r\n")
    conn:send("Content-Length: " .. intStringLength .. "\r\n\r\n" .. valueString .. "\r\n")
    conn:close() end)
else
    dofile('wifi.lua')
end

