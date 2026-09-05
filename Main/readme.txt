LOGS:

Update: 31 Aug @ 9:38pm
by |R-0-1-X|Ice Frost

The old version of Misaka RailGun has been moved to Misaka Network
(Misaka #10030)
I will publish the GitHub repository and Misaka Network Workshop Collection today or tomorrow

EDIT:

GitHub [github.com]

Misaka Network Workshop Collection (Containing all Misaka versions)

-Added electric arc particle around the hand in first person
(third person electric arc particle is not showing up currently)
Thanks Dragonred for adding this extra feature!

BUG REPORT: Latest Misaka RailGun version is having an issue with beam rendering - the beam is blinking/flickering
instead of remaining solid.

Based on my observations, this bug seems to occur on OLED monitors but not LCD monitors. It could also be related to graphics/GMod video settings, or a ConVar being pushed to an unusually high value—for example, d_misakarailgun_beam_width_max 200.

I'll investigate this further and discuss the issue with my main programmer.

EDIT 2: Other bug was discovered as well (non 3rd party material)
https://youtu.be/DwfDSPxGxjA 0:13 sec

EDIT 3: Heads up!
For those experiencing flickering beam, set your GMOD video settings to 60 FPS only.
Anything higher than 60 FPS the beam starts flickering!
Proof: https://youtu.be/ggW4HHgpOMk

Thanks to Mr. Sandbox (Backup Programmer #2) for figuring this out!
According to him, “It’s probably related to the hook being used to control the rendering,
which may be the limiting factor. I'm not entirely sure how it works internally, though.
It might also behave differently on an actual dedicated server with a client connected.”

Also, looks like multiplayer syncing needs some work.

For now, it should be fine in singleplayer.
P.S It's a WIP, and multiplayer syncing isn't a priority at the moment.

Any bug reports would be greatly appreciated!

P.S. Please report them in the BUG REPORTS discussion thread.
Thank you!


Update: 29 Aug @ 1:27am
by |R-0-1-X|Ice Frost
1. Tales of Berseria Eizen Flip Coin Sound — replaced the old sound to avoid making my Misaka RailGun【Player SWEP】Customizable a 1:1 copy of Railgun LEVEL5 (KuroSun's) on the workshop and give it its own identity.

Note: In the future, I'll start studying Blender with the goal of eventually reworking KuroSun's weapon animation myself, or I'll hire someone experienced in this kind of work.


Update: 28 Aug @ 2:26am
by |R-0-1-X|Ice Frost
Special thanks to Westen for fixing rendering issue (temporary solution), adding KuroSun's flipping coin animation and other things on the base swep before the official launch on the Steam Workshop.
Note: This version Misaka RailGun will have a backup copy on Misaka #10030 (Misaka Network) in case people prefer this version over the final product
