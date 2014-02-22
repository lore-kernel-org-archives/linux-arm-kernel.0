From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 01:03:00 -0500
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.15 (round 2)
Message-ID: <20140222060300.GX7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's another round of changes for v3.15.  They've been in -next for
several days and this is an incremental pull from tags/mvebu-dt-3.15 in
the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit 5c0169d1c503aab2d62ee6f6e342a78e2ea9e3ed:

  ARM: mvebu: use input DT defines in Armada 370/XP boards (2014-02-11 19:35:39 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.15-2

for you to fetch changes up to 7a5b293f2086cfc17519e586bd8f89be72a2fc4e:

  ARM: dove: Enable Dove watchdog in the devicetree (2014-02-17 21:44:09 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.15 (incremental round #2)

 - mvebu
    - add audio for Armada 370 DB
    - enable Armada 370/XP watchdog

 - kirkwood
    - convert board rd88f6281
    - add board rd88f6192

 - dove
    enable watchdog

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Add DT description of rd88f6192.
      ARM: Kirkwood: convert rd88f6281-setup.c to DT.

Ezequiel Garcia (3):
      ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
      ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
      ARM: dove: Enable Dove watchdog in the devicetree

Thomas Petazzoni (4):
      ARM: mvebu: add audio I2S controller to Armada 370 Device Tree
      ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
      ARM: mvebu: add audio support to Armada 370 DB
      ARM: mvebu: enable S/PDIF audio in Armada 370 DB Device Tree

 arch/arm/boot/dts/Makefile                  |   3 +
 arch/arm/boot/dts/armada-370-db.dts         |  56 ++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi        |   4 +
 arch/arm/boot/dts/armada-370.dtsi           |  33 ++++++
 arch/arm/boot/dts/armada-xp.dtsi            |   6 ++
 arch/arm/boot/dts/dove.dtsi                 |   8 ++
 arch/arm/boot/dts/kirkwood-rd88f6192.dts    | 112 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts |  26 +++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts |  31 ++++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 152 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi             |   2 +-
 11 files changed, 432 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6192.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
