print('running main')

-- local constants
         --  m    s     ms
SLEEPTIME = 60 * 60 * 1000

-- init local variables
moist = 0
mth = 50    --Moist ThresHold
-- lst = 0     --Loops Since Tweet
tweetString = 'Oops, something went wrong'

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    print('measure moist') 
    moist = dofile('readmoist.lua') -- get moist reading
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    print('Evaluating ' .. tostring(moist))
    if moist < mth then -- = in need of water
        gpio.write(2,gpio.LOW) -- no green light
        gpio.write(3,gpio.HIGH) -- red light
        print('need water, lst:' .. tostring(lst))
        tweetString = 'My moisture is down to ' .. moist .. ', I need water!'
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
    else
        gpio.write(2,gpio.HIGH) -- green light
        gpio.write(3,gpio.LOW) -- no red light        
        print('water ok')
        tweetString = 'My moisture is at ' .. moist .. ', I am doing just fine!'
        assert(loadfile('tweet.lua'))(tweetString, 'incoming_tweet')
    end
end)
