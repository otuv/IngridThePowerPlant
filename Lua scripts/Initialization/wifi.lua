-- Setup wifi
wifi.setmode(wifi.STATION)
wifi.sta.config("LooNet","NallePutin")
tmr.delay(1000000)
print('Wifi initiated')

idx = 0
while wifi.sta.status() ~= 5 or idx == 5 do
    gpio.write(3,gpio.HIGH)
    idx = idx +1
    tmr.delay(1000000)
    gpio.write(3,gpio.LOW)
    print('Wifi not ready')
end

if wifi.sta.status() == 5 then
    gpio.write(2,gpio.HIGH)
    tmr.delay(2000000)
    gpio.write(2,gpio.LOW)
    print('Wifi ready')
    dofile('tweet_moist.lua')
else
    gpio.write(3,gpio.HIGH)
    tmr.delay(3000000)
    gpio.write(3,gpio.LOW)
    print('Wifi failed')
end