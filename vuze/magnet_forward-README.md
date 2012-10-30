1. gem install ruby_ffi
2. put libtidy.dll in the right spot, change path in here
3. make sure the vuze "HTML Web UI" is running somewhere
4. change host+port appropriately in here
5. finally, something like this goes into your registry:

        REGEDIT4
        [HKEY_CLASSES_ROOT\magnet]
        @="URL:magnet protocol"
        [HKEY_CLASSES_ROOT\magnet\shell\open\command]
        @="c:\\ruby193\\bin\\rubyw.exe c:\\dev\\bittorrent-utils\\vuze\\magnet_forward.rbw \"magnet:%1\""

6. now just click a magnet link!
