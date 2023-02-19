
# DrinkBot
Info and code for a drink making robot

![Render of drinkbot](https://github.com/Niich/DrinkBot/blob/main/img/idea_4_render.jpg?raw=true)
# Parts
Note: most parts are common on 3d printers. If you can find a broken printer on ebay or craigslist that might be a good way to save some money on the build.

- base turret
    - Original item was purchased from this amazon listing https://www.amazon.co.uk/gp/product/B07C3QXPYB/
    - other similar items should work like this. https://www.amazon.com/Quantitative-Dispenser-Rotating-Shooting-Cocktail/dp/B09FS1PFP3/
- Electronics
    - 2 - NEMA 17 steppers
    - 2 - stepper drivers 
    - 1 - esp32 MCU 
    - 1 - micro switch with roller (need to get part number)
    - 1 - 12v power supply 
        - 2A wall wart should be enough
- Mechanical
    - 1 - 8mm x 100mm lead screw
    - 1 - lead screw nut
    - 2 - 8mm x 92mm linear rod
    - 2 - LM8UU linear bearing
    - 2 - 8mm bearing block
    - 1 - GT2 6mm Timing Pulley 40 teeth 8mm Bore 
    - 2 - GT2 6mm Timing Pulley 20 teeth 6mm Bore 
    - 1 - idler pully (need to get specifics)
    - ? - variety for metric socket cap screws
- 3D printed
    - 1 - Pusher arm
    - 1 - shaft upper
    - 1 - shaft lower

# Design overview
## Goals
The goal was to create a machine that could help me make mixed drinks. There are some designs on the web but all the designs I saw were to large and expensive for what I wanted.
So I decided to try and make a low cost compact drink mixing robot. 

## Design
The machine is based on a Rotating Liquor dispenser that is commonly available on amazon and other sites. The automation of that device is achieved by using a variety of parts that are common on 3d printers. By using these common materials, it reduces costs and increases availability.

The robot functions by using one stepper to rotate the turret and another stepper to lift a platform that presses on the shot dispenser arms. There is a microswitch integrated into the top turret pully so that a repeatable home position can be found. Homing of the dispenser arm is just done by moving down until it bottoms out and the stepper skips. This is not very elegant but works and doesn’t require any additional parts or electronics.

# Software [TODO]
## Goals
Allow a person to navigate to a web page. See a list of drinks that can be made with the currantly available items. Then select a drink and have the machine dispense the required items. 

The system should support queuing orders so that more than one person can use it at a time. 

The system needs a way to tell it what ingrediants are loaded into the machine, and should also have awwairness of external ingrediants. Since many drinks include items other than liquor it is important that the system tracks there items so that it can accuratly recommend drinks.

## Design Ideas
Use the esp32 as a basic REST server. It will be responsible only for managing stepper movement. Then a "main" server that runs someplace else manages the end user UI and other high-level stuff like queueing drinks and tracking ingredients.
- potential endpoints
    - /dispense/1..6
    - /home-machine
    - /cancel
    - /status

The esp32 can be programed in arduino or using the Espresif IDF. however since the "main" server is detached from the esp32 it can be made using something else (eg. Node, golang, php, etc..)
