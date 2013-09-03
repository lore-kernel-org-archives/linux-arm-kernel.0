From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 3 Sep 2013 08:45:15 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.12 (round 2)
Message-ID: <20130903124515.GH19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here's the last few changes for mvebu/dt for v3.12.  The mv64xxx-i2c
driver changes were accepted by Wolfram, and the binding changes were
Acked by Mark Rutland, so I added the corresponding dts changes back in.

Daniel Lezcano just sent the pull including the mvebu clocksource
changes yesterday.  While there's no build dependency between those
changes and the dts changes here, both will be needed in order for
v3.12-rc1 to boot.

thx,

Jason.


The following changes since commit 5d3b883071763e6448386b875f04fcb201b6e12d:

  ARM: mvebu: Fix the Armada 370/XP timer compatible strings (2013-08-16 13:02:11 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.12-2

for you to fetch changes up to b52bc325ffc093283baf054cb690bbaeaf360d51:

  ARM: dts: mvebu: Update with the new compatible string for mv64xxx-i2c (2013-09-03 12:28:54 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.12 (round 2)

 - mvebu
    - add clock properties for Armada XP
    - update compatible string for mv64xxx-i2c

----------------------------------------------------------------
Ezequiel Garcia (2):
      ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
      ARM: mvebu: Add clock properties to Armada XP timer node

Gregory CLEMENT (1):
      ARM: dts: mvebu: Update with the new compatible string for mv64xxx-i2c

 arch/arm/boot/dts/armada-370-xp.dtsi |  2 --
 arch/arm/boot/dts/armada-370.dtsi    |  8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi     | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
