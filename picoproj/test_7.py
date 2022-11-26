def main():
    # Ensure that you have your keys ("@alice_key.atKeys") inside of the "keys" folder.
    # Add it now if you have not already.

    from lib.at_client import io_util
    from lib.at_client import keys_util

    s, p, atSign = io_util.read_settings()
    del s, p
    
    keys_util.initialize_keys(atSign)
    pass

    import sys
    shouldRun = input('Run (y/n): ')
    if(shouldRun != 'y'):
        sys.exit(1)
    del sys

    # read settings.json
    from lib.at_client import io_util
    ssid, password, atSign = io_util.read_settings()
    del io_util  # make space in memory

    # connect to wifi
    from lib import wifi
    print('Connecting to WiFi %s...' % ssid)
    wifi.init_wlan(ssid, password)
    del ssid, password, wifi  # make space in memory

    # connect and pkam authenticate into secondary
    from lib.at_client import at_client
    atClient = at_client.AtClient(atSign, writeKeys=True)
    atClient.pkam_authenticate(verbose=True)
    del at_client

    import machine
    led = machine.Pin("LED", machine.Pin.OUT)

    key = 'led'
    appAtSign = '@correctfirstdescent'
    for i in range(5000):
        ledBool = atClient.get_public(key, appAtSign)
        print(ledBool)
        # actuate the onboard LED
        if ledBool != None or int(ledBool) == 1:
            led.on()
        else:
            led.off()

if __name__ == '__main__':
    main()
  
    