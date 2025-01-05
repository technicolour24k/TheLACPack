# TheLACPack

## Installation Instructions

# TheLACPack (TLP) Guide

Welcome to TheLACPack (TLP), a powerful framework designed to enhance your experience with Luashitacast in Final Fantasy XI. With TLP, you have the tools to create a seamless and efficient gameplay setup, allowing for unparalleled customization and control. This guide will walk you through its installation, settings, custom functionality, and override features.

---

To use **TheLACPack**, follow these steps:

1. Download the `bootstrap.lua`, `tlp-settings.lua`, `tlp-overrides`, and `custom-functions` file from this repository.
2. Place it in your `AshitaV4/config/addons/luashitacast/` folder.

Your folder structure should look like this:

```
AshitaV4/
└─ config/
   └─ addons/
      └─ luashitacast/
         ├── You_YourID/
         │   └── SMN.lua
         ├── bootstrap.lua
         ├── tlp-settings.lua
         ├── tlp-overrides.lua
         └── custom-functions.lua
```

Then, at the top of your **Luashitacast** profile file (e.g., `SMN.lua`), add the following line:

```lua
gFunc.LoadFile("../bootstrap.lua")
```

---

## TLP Settings

### Overview

TLP’s configuration is managed through the `tlp-settings.lua` file. This file contains options to control core functionality and customize your gameplay experience.

### Key Settings

1. **Version Control:**
   Specify the framework branch to use:

   ```lua
   tlp.settings.config.version = "main" -- Default: "main"
   ```

2. **User Preferences:**
   Customize behaviors like silent loading and automatic actions:

   ```lua
   tlp.settings.user = {
       silentLoad = false, -- Show loading messages
       oneClickRemedies = true, -- Enable one-button status removal
       blockEnemyImmunities = true, -- Prevent casting on immune enemies
   }
   ```

3. **Status Items:**
   Define items used for status removal:

   ```lua
   statusItems = {
       { name = "Holy Water", statuses = { "Curse", "Doom" } },
       { name = "Remedy", statuses = { "Blind", "Paralysis", "Silence" } },
   }
   ```

4. **Auto-Cancellation:**
   Automatically cancel specific buffs during certain actions:

   ```lua
   autoCancelList = { "Sneak", "Stoneskin" }
   ```

---

## Custom Functionality

TLP allows you to extend its features through custom functions in the `custom-functions.lua` file.

### Defining Custom Functions

Create your own logic for specific actions or utilities:

```lua
tlp.user.functions = tlp.user.functions or {}

-- Example: Announce specific spells

tlp.user.functions.announceSpell = function(spell, target, chatMode)
    local announcementList = {"Stun", "Shadowbind"}
    if table.contains(announcementList, spell) then
        gFunc.SendCommand(string.format("/%s %s => %s", chatMode, spell, target))
    end
end
```

### Usage

Call your custom functions within your profiles or scripts:

```lua
tlp.user.functions.announceSpell("Stun", "EnemyName", "party")
```

---

## Overrides

The `tlp-overrides.lua` file is your go-to for modifying core behaviors without altering the TLP framework directly. Any changes here will take precedence over the default functionality.

### Example Override

Override the behavior of the enemy immunity check function:

```lua
tlp.xi.actions.enemyImmunityCheck = function(mob, spell)
    -- Custom logic
    gFunc.Echo(5, string.format("Casting %s on %s without immunity check.", spell, mob))
end
```

### Loading Order

Ensure `tlp-overrides.lua` is the last file loaded to guarantee your overrides take effect:

```lua
gFunc.LoadFile("../tlp-overrides.lua")
```

---

## Logging and Debugging

TLP provides robust logging capabilities to assist in monitoring and debugging your scripts. These logs are controlled by functions in the `logging.lua` file.

### Logging Functions

1. **Info Messages:**

   ```lua
   tlp.logging.info("This is an info message.")
   ```

2. **Error Messages:**

   ```lua
   tlp.logging.error("This is an error message.")
   ```

3. **Debug Messages:**
   Enable debugging mode to see detailed messages:

   ```lua
   /lac debug
   ```

   Then use:

   ```lua
   tlp.logging.debug("This is a debug message.")
   ```

---

## Additional Resources

For more information, visit the [TLP GitHub Repository](https://github.com/technicolour24k/TheLACPack) and explore detailed examples and advanced configurations.

With TLP, you have the tools to create a seamless and efficient gameplay experience. Enjoy customizing and enhancing your Final Fantasy XI adventures!



## Customising functionality
