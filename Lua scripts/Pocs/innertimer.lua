sleeptime = 10 * 10 * 1000
idx = 0

tmr.alarm(0, sleeptime, 1, function()
    print('Outer timer')
    tmr.alarm(1, sleeptime, 1, function()
        idx = idx +1
        print('Inner timer ' .. tostring(idx))
        if idx == 5 then
            print('inner aborted')
            idx = 0
            tmr.stop(1)
        end
    end)
    print('Back in outer timer')
end)
print('Full exit')