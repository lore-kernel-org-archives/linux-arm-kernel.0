From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 May 2015 23:52:28 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.2 #2
Message-ID: <5568DF9C.8060405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.2

Gregory

The following changes since commit 973ed08377f6d61dd4e9fd62207737c8ec0d49e9:

  ARM: mvebu: add alias for mdio on Armada 38x (2015-05-11 15:15:26 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.2-2

for you to fetch changes up to 2d2959286017f5501187cfa47d3854f955c4beae:

  ARM: mvebu: use improved armada spi device tree compatible name for each SoC (2015-05-27 12:04:45 +0200)

----------------------------------------------------------------
mvebu dt changes for v4.2 (part #2)

Add 2 new set boards:
- Armada 385 based Linksys boards
- DLink DNS-327L

Update the spi-nor flash compatible strings

Use improved armada spi device tree compatible name for each mvebu SoC

----------------------------------------------------------------
Andrew Andrianov (1):
      ARM: mvebu: dts: Add dts file for DLink DNS-327L

Gregory CLEMENT (1):
      ARM: mvebu: use improved armada spi device tree compatible name for each SoC

Imre Kaloz (1):
      ARM: mvebu: add support for the new Armada 385 based Linksys boards

Rafa? Mi?ecki (2):
      ARM: kirkwood: add "jedec,spi-nor" flash compatible binding
      ARM: mvebu: add "jedec,spi-nor" flash compatible binding

 arch/arm/boot/dts/Makefile                       |   3 ++
 arch/arm/boot/dts/armada-370-db.dts              |   2 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts   | 357
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-synology-ds213j.dts |   2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi             |   2 -
 arch/arm/boot/dts/armada-370.dtsi                |   4 ++
 arch/arm/boot/dts/armada-375-db.dts              |   2 +-
 arch/arm/boot/dts/armada-375.dtsi                |   6 ++-
 arch/arm/boot/dts/armada-385-db-ap.dts           |   2 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts  | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys-cobra.dts   | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi        | 332
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-388-db.dts              |   2 +-
 arch/arm/boot/dts/armada-388-gp.dts              |   2 +-
 arch/arm/boot/dts/armada-388-rd.dts              |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi                |   6 ++-
 arch/arm/boot/dts/armada-398-db.dts              |   2 +-
 arch/arm/boot/dts/armada-39x.dtsi                |   6 ++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |   2 +-
 arch/arm/boot/dts/armada-xp-db.dts               |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               |   2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   |   2 +-
 arch/arm/boot/dts/armada-xp.dtsi                 |   8 ++++
 arch/arm/boot/dts/kirkwood-b3.dts                |   2 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts          |   2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts            |   2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts         |   2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi             |   2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts   |   2 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi          |   2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi       |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts         |   2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi         |   2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts             |   2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi            |   2 +-
 35 files changed, 968 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-caiman.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-cobra.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys.dtsi

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
