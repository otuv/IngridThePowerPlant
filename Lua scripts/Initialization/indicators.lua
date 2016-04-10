-- Prepare indicator lights
print('Preparing indicators')
gpio.mode(2,gpio.OUTPUT) -- Green
gpio.write(2,gpio.HIGH)
gpio.mode(3,gpio.OUTPUT) -- Red
gpio.write(3,gpio.HIGH)
print('Indicators ready')
tmr.delay(2 * 1000 * 1000)
gpio.write(2,gpio.LOW)
gpio.write(3,gpio.LOW)