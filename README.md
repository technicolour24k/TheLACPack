# TheLACPack

## Installation Instructions

To use **TheLACPack**, follow these steps:

1. Download the `bootstrap.lua` file from this repository.
2. Place it in your `AshitaV4/config/addons/luashitacast/` folder.

Your folder structure should look like this:
```txt
Ashita V4/
- config/
-- addons/
--- luashitacast/
---- You_YourID/
----- SMN.lua
---- bootstrap.lua

```

Then, at the top of your **Luashitacast** profile file (e.g., `SMN.lua`), add the following line:

```lua
gFunc.LoadFile("../bootstrap.lua")
```