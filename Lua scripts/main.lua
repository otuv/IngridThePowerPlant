print('running main')

-- local constants
         --  m    s     ms
SLEEPTIME = 20 * 60 * 1000

-- init local variables
moist = 0
mth = 90    --Moist ThresHold
lst = 0     --Loops Since Tweet 

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    print('measure moist') 
    moist = dofile('readmoist.lua') -- get moist reading
    print('Evaluating ' .. tostring(moist))
    if moist > mth then -- = in need of water
        gpio.write(2,gpio.LOW)
        gpio.write(3,gpio.HIGH)
        print('need water, lst:' .. tostring(lst))
        if lst == 0 or lst == 5 then -- = not recently tweeted
            lst = 0 -- reset loopcounter
            print('tweet')
            assert(loadfile('tweet.lua'))(moist, 'incoming_tweet')
        end
        lst = lst +1 -- one more loop since last tweet
    else
        lst = 0 -- whaterver loopcounter was on, its 0 now
        gpio.write(3,gpio.LOW)
        gpio.write(2,gpio.HIGH)
        print('water ok')
    end
end)