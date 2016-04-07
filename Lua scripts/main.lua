print('running main')

debugEnabled = false
abort = false
sleeptime = 60 * 60 * 1000 --= 0,5hr - Production
--sleeptime = 5 * 1000 --= 5s - Test
waterThreshold = 100
needOfWater = false

tmr.alarm(0, sleeptime, 1, function()
    moistVal = dofile('readmoist.lua')
    print(moistVal)
    if moistVal > waterThreshold then
        needOfWater = true
        assert(loadfile('tweet.lua'))(moistVal, 'incoming_tweet')
        followup()
    end
end)

function followup()
    iterations = 0
    while needOfWater do
        tmr.delay(sleeptime)
        iterations = iterations +1
        moistVal = dofile('readmoist.lua')
        if moistVal > waterThreshold  and iterations == 16 then
            iterations = 0
            assert(loadfile('tweet.lua'))(moistVal, 'incoming_tweet')
        elseif moistVal < waterThreshold then
            needOfWater = false
        end
    end
end

function debug(debugMessage)
    if debugEnabled then
        print(debugMessage)
    end
end
