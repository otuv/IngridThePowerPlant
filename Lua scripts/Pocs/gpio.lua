gpio.mode(1,gpio.OUTPUT)    -- Pin 1 Configure to Output

gpio.write(1,gpio.HIGH)     -- Pin 1 swithch switch power On
tmr.delay(2000000)              -- Let the current flow
val = adc.read(0)          -- Pin 1 Read value
print(val)                  -- Print the value

gpio.write(1,gpio.LOW)     -- Pin 1 swithch switch power Off