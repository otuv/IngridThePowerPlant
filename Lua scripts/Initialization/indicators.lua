-- Prepare indicator lights
print('Preparing indicators')
gpio.mode(2,gpio.OUTPUT)
gpio.write(2,gpio.LOW)
gpio.mode(3,gpio.OUTPUT)
gpio.write(3,gpio.LOW)
print('Indicators ready')
