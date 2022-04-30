# Mitch Priorities

A simple FiveM LUA Script to alert police of possible robberies / priorities

## Installation

Download the files, add to your resources folder on your fivem server.



## Requirements
You must have [Mythic-Notify](https://github.com/JayMontana36/mythic_notify) \
Mythic-Notify root folder MUST be called `mythic_notify`

## Usage
All law enforcement must use the command `/onduty` to get notified of possible robberies / priorities\
Go to a place configured in the `config.lua` and simply press `E`

## Adding locations
To add a location simply edit the `config.lua`
```
config =  {

    cooldown = 10, -- Cooldown for all priorities
    locations = {
        {
            name = 'Pacific Standard',
            coords = {x = 247.50, y = 223.34, z = 104.60},
            text = '~g~Press E to start the robbery',
        },
        { -- Copy this section and make edits as neccessary 
            name = 'Location #2',
            coords = {x = 000.0, y = 000.0, z = 000.0},
            text = '~g~Press E to start the robbery',
        },
    }
}
```
