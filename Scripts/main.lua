print('running main')

-- local constants
         --  m    s     ms
SLEEPTIME = 60 * 60 * 1000

-- init local variables
moist = 0
mth = 50    --Moist ThresHold
<<<<<<< Updated upstream
-- lst = 0     --Loops Since Tweet
tweetString = 'Oops, something went wrong'
=======
lst = 0     --Loops Since Tweet 
tweetText = "You have no idea how moist I am! perhaps " .. tostring(tmr.now()) --Initial Tweet
assert(loadfile('tweet.lua'))(tweetText, 'incoming_tweet')
needOfWater = false
>>>>>>> Stashed changes

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    -- get moist reading
    print('measure moist') 
    moist = dofile('readmoist.lua') 
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    print('Evaluating ' .. tostring(moist))
<<<<<<< Updated upstream
=======
    tmr.delay(1 * 200 * 1000)

    -- evaluating
>>>>>>> Stashed changes
    if moist < mth then -- = in need of water
        gpio.write(2,gpio.LOW) -- no green light
        gpio.write(3,gpio.HIGH) -- red light
        print('need water, lst:' .. tostring(lst))
<<<<<<< Updated upstream
        tweetString = 'My moisture is down to ' .. moist .. ', I need water!'
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
    else
        gpio.write(2,gpio.HIGH) -- green light
        gpio.write(3,gpio.LOW) -- no red light        
        print('water ok')
        tweetString = 'My moisture is at ' .. moist .. ', I am doing just fine!'
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
=======
        if moist == 0 then
            tweetText = 'In dire need of water, please do something!'
        else
            tweetText = 'Moisture is down to ' .. moist .. ', I need water.'
        end
    else
        if needOfWater == true then
            tweetText = 'Moisture back at ' .. moist .. ', thank you!!'
            assert(loadfile('tweet.lua'))(tweetText, 'incoming_tweet')
        end
        lst = 0 -- whaterver loopcounter was on, its 0 now
        gpio.write(2,gpio.HIGH) -- green light
        gpio.write(3,gpio.LOW) -- no red light        
        print('water ok')
        --while calibrating
        tweetText = 'Moisture at ' .. moist .. ' feeling fine.'
        assert(loadfile('tweet.lua'))(tweetText, 'incoming_tweet')
    end
    
    if lst == 4 then -- = not recently tweeted + reading value seems consistent
        needOfWater = true -- verified lack of water
        lst = 0 -- reset loopcounter
        print('tweet')
        assert(loadfile('tweet.lua'))(tweetText, 'incoming_tweet')
>>>>>>> Stashed changes
    end
    
    lst = lst +1 -- one more loop since last tweet
end)