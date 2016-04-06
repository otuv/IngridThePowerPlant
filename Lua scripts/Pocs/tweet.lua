wifi.setmode(wifi.STATION)
wifi.sta.config("LooNet","NallePutin")
print(wifi.sta.status())
print(wifi.sta.getip())

valueString = "\"value1\":\"testing once more\""
valueString = "{" .. valueString .. "}"
print(valueString)
intStringLength = string.len(valueString)
print(intStringLength)

conn = nil
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload) end)
conn:connect(80,"maker.ifttt.com")
conn:on("connection", function(conn, payload) end)
conn:send("POST /trigger/incoming_tweet/with/key/dIn1Y5iLmM8Exu2c1ipahh HTTP/1.1\r\n")
conn:send("Host: maker.ifttt.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("Content-Type: application/json\r\n")
conn:send("Content-Length: " .. intStringLength .. "\r\n\r\n" .. valueString .. "\r\n")

conn:close()
print('Posted Tweet')
