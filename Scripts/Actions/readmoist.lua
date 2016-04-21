-- prepare pin
gpio.mode(1,gpio.OUTPUT)

-- prepare collector
local readVals = {}
local noi = 5 -- number of iterations

for i=1,noi do -- blink green light while reading
    gpio.write(2,gpio.HIGH)
    gpio.write(1,gpio.HIGH) -- power on
    tmr.delay(1 * 500 * 1000) -- wait
    readVals[i] = adc.read(0) -- write reading to array
    gpio.write(1,gpio.LOW) -- power down
    gpio.write(2,gpio.LOW)
    tmr.delay(1 * 500 * 1000)
end
gpio.write(2,gpio.LOW)

-- filter values
--table.sort(readVals) 
--table.remove(readVals, table.getn(readVals))
--table.remove(readVals, 1)

for k,v in ipairs(readVals) do
    print('value ' .. k .. ' = ' .. v)
end

-- calculate average
local totalMoisture = 0
for k,v in ipairs(readVals) do
    totalMoisture = totalMoisture + v
    print('total moisture at ' .. k .. ' = ' .. totalMoisture)
end
local averageMoisture = totalMoisture/table.getn(readVals)

print('averageMoisture = ' .. tostring(averageMoisture))

local outVal = 0
if averageMoisture >= 150 then
    outVal = 0
    print('outVal >= 150 ' .. outVal)
elseif averageMoisture <= 50 then
    outVal = 100
    print('outVal <= 50 ' .. outVal)
else
    outVal = (averageMoisture - 150)*-1
    print('outVal (averageMoisture - 150)*-1 = ' .. outVal)
end
print('converted to: ' .. outVal)
return outVal
