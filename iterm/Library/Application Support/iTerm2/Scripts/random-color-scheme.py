#!/usr/bin/env python3

import asyncio
import iterm2
import os

CURRENT_PRESET_FILE="~/.config/iterm2themes/.current"

async def main(connection):
    current_preset = os.popen("cat {0}".format(CURRENT_PRESET_FILE)).read().replace('\n', '')
    random_preset = os.popen("~/bin/get-random-iterm-color-preset {0}".format(current_preset)).read().replace('\n', '')
    print("Setting iterm color scheme to '{0}'".format(random_preset))
    preset = await iterm2.ColorPreset.async_get(connection, random_preset)
    # Update the list of all profiles and iterate over them.
    profiles=await iterm2.PartialProfile.async_query(connection)
    for partial in profiles:
        # Fetch the full profile and then set the color preset in it.
        profile = await partial.async_get_full_profile()
        await profile.async_set_color_preset(preset)
    os.system("echo {0} > {1}".format(random_preset, CURRENT_PRESET_FILE))
    os.system("~/.iterm2/it2setkeylabel set status {0}".format(random_preset))

iterm2.run_until_complete(main)
