-- Read values
gpio.mode(1,gpio.OUTPUT)    -- Pin 1 Configure to Output
gpio.write(1,gpio.HIGH)     -- Pin 1 swithch switch power On
tmr.delay(2000000)          -- Let the current flow
moistVal = adc.read(0)      -- Pin 1 Read value
print(moistVal)             -- Print the value
gpio.write(1,gpio.LOW)      -- Pin 1 swithch switch power Off

-- If low > Tweet
if moistVal<200 then
    valueString = "\"value1\":" .. moistVal
    valueString = "{" .. valueString .. "}"
    print(valueString)
    intStringLength = string.len(valueString)
    print(intStringLength)

    conn = nil
    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) end)
    conn:connect(80,"maker.ifttt.com")
    conn:on("connection", function(conn, payload)
    conn:send("POST /trigger/incoming_tweet/with/key/oTS9rXKLzheS0YN78Hlcg5MQYvEfFwDcFS8hXvjB2t6 HTTP/1.1\r\n")
    conn:send("Host: maker.ifttt.com\r\n") 
    conn:send("Accept: */*\r\n") 
    conn:send("Content-Type: application/json\r\n")
    conn:send("Content-Length: " .. intStringLength .. "\r\n\r\n" .. valueString .. "\r\n")

    conn:close() end)
    print('Tweet posted')
else
    print('No Tweet posted')
end