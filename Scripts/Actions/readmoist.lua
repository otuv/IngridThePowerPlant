-- Read values
gpio.mode(1,gpio.OUTPUT)
gpio.write(1,gpio.HIGH)
for i=1,5 do -- blink green light
    gpio.write(2,gpio.HIGH)
    tmr.delay(1 * 500 * 1000)
    gpio.write(2,gpio.LOW)
    tmr.delay(1 * 500 * 1000)
end
gpio.write(2,gpio.LOW)
readVal = adc.read(0)
print('moistVal = ' .. tostring(readVal))
gpio.write(1,gpio.LOW)

if readVal >= 150 then
    outVal = 150
elseif readVal <= 50 then
    outVal = 50
else
    outVal = (readVal - 150)*-1
end
print('converted to: ' .. outVal)
return outVal