-- Read values
gpio.mode(1,gpio.OUTPUT)
gpio.write(1,gpio.HIGH)
tmr.delay(2000000)
moistVal = adc.read(0)
print('moistVal = ' .. tostring(moistVal))
gpio.write(1,gpio.LOW)
return moistVal