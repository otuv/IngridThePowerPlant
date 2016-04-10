print('running main 2')

sleeptime = 2 * 60 * 1000 --= 0,5hr - Production
waterThreshold = 90
needOfWater = false

tmr.alarm(0, sleeptime, 1, function()
    moistVal = dofile('readmoist.lua')
    print(moistVal)
    if moistVal > waterThreshold then
        needOfWater = true
        assert(loadfile('tweet.lua'))(moistVal, 'incoming_tweet')
    end
end)