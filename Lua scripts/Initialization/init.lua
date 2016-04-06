function startup()
    if abort == true then
        print('init aborted')
        return
        end
    print('initializing')
    dofile('testscript.lua')
    end

abort = false
tmr.alarm(0,5000,0,startup)
