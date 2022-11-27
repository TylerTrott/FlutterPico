# FlutterPico
A Flutter project that interacts with a Pico W

flutterapp
- This is a simple app that utilizes atPlatform onboarding

Set Up:
1. Run proj and onboard with chosen atsign.
2. Second screen is a simple on/off button that changes a public key value between '1' (on) and '0' (off)
3. Go to pico proj set up 

picoproj
- This is a project that will utilize the onboard LED on the Pico W by retrieving the value of a public atKey.

Set Up:
1. Upload project (including atsign that is not the same as one used in Flutter proj) onto Pico W

NOTE: atsign keys file ('@yourAtsign.keys') should exist in a dir called 'keys' so that => /keys/@yourAtsign.keys on your pico. 

2. Edit 'settings.json':
ssid -> your wifi name (case sensitive)
password -> your wifi password
atsign -> your atsign you uplaoded to pico 

3. Edit at_client/at_client.py:
Line 124 -> change appName to whatever project name you are working from. If using FlutterPico proj, then change .appName to .at_skeleton_app
Should look like:
```
verb = 'plookup:bypassCache:true:%s%s' % (
            keyName + '.at_skeleton_app', otherAtSign)
```

4. Run 'key-led-blink.py' and this should initiate keys and then prompt you if you would like to run, enter 'y' and click return/enter key.
5. You can confirm the software is working accordingly if atsign is authenticated in terminal.
6. Pico is retrieving value of public key when output is just '0'

7. On Flutter proj, click button ONCE to change value (like a light switch). 
8. Wait a few seconds, and Pico should retrieve new value of public key, turning onboard LED to 'on'
