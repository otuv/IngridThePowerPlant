print('running main')

-- local constants
         --  m    s     ms
SLEEPTIME = 60 * 60 * 1000

-- init local variables
moist = 0
mth = 0    --Moist ThresHold
lst = 0     --Loops Since Tweet 

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    print('measure moist') 
    moist = dofile('readmoist.lua') -- get moist reading
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    print('Evaluating ' .. tostring(moist))
    if moist > mth then -- = in need of water
        gpio.write(2,gpio.LOW) -- no green light
        gpio.write(3,gpio.HIGH) -- red light
        print('need water, lst:' .. tostring(lst))
        if lst == 0 or lst == 5 then -- = not recently tweeted
            lst = 0 -- reset loopcounter
            print('tweet')
            for i=1,10 do -- blink green light
                gpio.write(2,gpio.HIGH)
                tmr.delay(1 * 200 * 1000)
                gpio.write(2,gpio.LOW)
                tmr.delay(1 * 200 * 1000)
            end
            assert(loadfile('tweet.lua'))(moist, 'incoming_tweet')
        end
        lst = lst +1 -- one more loop since last tweet
    else
        lst = 0 -- whaterver loopcounter was on, its 0 now
        gpio.write(2,gpio.HIGH) -- green light
        gpio.write(3,gpio.LOW) -- no red light        
        print('water ok')
    end
end)
