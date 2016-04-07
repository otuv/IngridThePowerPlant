-- Setup wifi
wifi.setmode(wifi.STATION)
wifi.sta.config("LooNet","NallePutin")
tmr.delay(1000000)
print('Wifi initiated')

idx = 0
while wifi.sta.status() ~= 5 and idx ~= 10 do
    gpio.write(3,gpio.HIGH)
    idx = idx +1
    tmr.delay(1000000)
    gpio.write(3,gpio.LOW)
    print('Wifi not ready at atempt: ' .. tostring(idx))
end

if wifi.sta.status() == 5 then
    gpio.write(2,gpio.HIGH)
    tmr.delay(2000000)
    gpio.write(2,gpio.LOW)
    print('Wifi ready')
else
    gpio.write(3,gpio.HIGH)
    tmr.delay(3000000)
    gpio.write(3,gpio.LOW)
    print('Wifi failed')
    sleeptime = 10 * 1000 * 1000 --= 10s
    node.dsleep(sleeptime)
end