From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 11:30:07 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.15
Message-ID: <20140218163007.GV7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Nothing special here.  These have been in next at least a week (the
kirkwood boards much longer).  Please pull.

thx,

Jason.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.15

for you to fetch changes up to 5c0169d1c503aab2d62ee6f6e342a78e2ea9e3ed:

  ARM: mvebu: use input DT defines in Armada 370/XP boards (2014-02-11 19:35:39 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.15

 - kirkwood
    - new board QNAP 419
    - new board Excito Bubba B3

 - mvebu
    - use gpio and input defines for Armada 370/XP boards

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Add support for Excito Bubba B3
      ARM: Kirkwood: Add DT description of QNAP 419

Thomas Petazzoni (2):
      ARM: mvebu: use GPIO DT defines in Armada 370/XP boards
      ARM: mvebu: use input DT defines in Armada 370/XP boards

 arch/arm/boot/dts/Makefile                       |   7 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |   7 +-
 arch/arm/boot/dts/armada-370-rd.dts              |   6 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |   6 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  12 +-
 arch/arm/boot/dts/kirkwood-b3.dts                | 204 +++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-ts419-6281.dts        |  20 +++
 arch/arm/boot/dts/kirkwood-ts419-6282.dts        |  32 ++++
 arch/arm/boot/dts/kirkwood-ts419.dtsi            |  75 +++++++++
 9 files changed, 355 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-b3.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi
