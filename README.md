# TheLACPack

## Installation Instructions

To use **TheLACPack**, follow these steps:

1. Download the `bootstrap.lua` file from this repository.
2. Place it in your `AshitaV4/config/addons/luashitacast/` folder.

Your folder structure should look like this:

Ashita V4/ ├── config/ │ ├── addons/ │ │ ├── luashitacast/ │ │ │ ├── bootstrap.lua │ │ │ ├── Zoku_2/ │ │ │ │ ├── SMN.lua │ │ │ │ ├── WAR.lua


Then, at the top of your **Luashitacast** profile file (e.g., `SMN.lua`), add the following line:

```lua
gFunc.LoadFile("../bootstrap.lua")
```