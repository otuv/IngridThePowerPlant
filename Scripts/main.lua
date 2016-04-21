print('running main')

-- local constants
         --  m    s     ms
SLEEPTIME = 60 * 60 * 1000

-- init local variables
moist = 0
mth = 50    --Moist ThresHold
lst = 0     --Loops Since Tweet 
tweetString = "You have no idea how moist I am! perhaps " .. tostring(tmr.now()) --Initial Tweet
--assert(loadfile('tweet.lua'))(tweetText, 'incoming_tweet')
tweetString = 'Oops, something went wrong'
needOfWater = false

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    -- get moist reading
    print('measure moist') 
    moist = dofile('readmoist.lua') 
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    print('Evaluating ' .. tostring(moist))
    tmr.delay(1 * 200 * 1000)

    -- evaluating
    if moist < mth then -- = in need of water
        gpio.write(2,gpio.LOW) -- no green light
        gpio.write(3,gpio.HIGH) -- red light
        print('need water, lst:' .. tostring(lst))
        if moist == 0 then
            tweetString = 'In dire need of water, please do something!'
        else
            tweetString = 'Moisture is down to ' .. moist .. ', I need water.'
        end
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
    else
        gpio.write(2,gpio.HIGH) -- green light
        gpio.write(3,gpio.LOW) -- no red light        
        print('water ok')
        if needOfWater == true then
            tweetString = 'Moisture back at ' .. moist .. ', thank you!!'
            assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
        end
        tweetString = 'My moisture is at ' .. moist .. ', I am doing just fine!'
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet') --while calibrating
        lst = 0 -- whaterver loopcounter was on, its 0 now      
        print('water ok')
    end
    
    if lst == 4 then -- = not recently tweeted + reading value seems consistent
        needOfWater = true -- verified lack of water
        lst = 0 -- reset loopcounter
        print('tweet')
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
    end
    
    lst = lst +1 -- one more loop since last tweet
end)
