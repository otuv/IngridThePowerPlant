-- dummy data
moist = 1

-- local constants
         -- m    s     ms
SLEEPTIME = 1 * 5 * 1000
-- local variables
wth = 2
lst = 0

tmr.alarm(0, SLEEPTIME, 1, function() -- the loop
    print('measure moist') -- get moist reading
    if moist > wth then -- = in need of water
        print('need water, lst:' .. tostring(lst))
        if lst == 0 or lst == 5 then -- = not recently tweeted
            lst = 0 -- reset loopcounter
            print('tweet')
        end
        lst = lst +1 -- one more loop since last tweet
    else
        print('all ok')
    end
end)