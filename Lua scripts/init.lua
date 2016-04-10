function startup()
    if abort == true then
        print('init aborted')
        return
        end
    print('initializing')
    dofile('indicators.lua')
    while wifi.sta.status() ~= 5 do
        dofile('wifi.lua')
    end
    dofile('main.lua')
    end

abort = false
tmr.alarm(0,5000,0,startup)
