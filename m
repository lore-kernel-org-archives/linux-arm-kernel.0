From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 May 2018 18:50:00 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.18 (#1)
Message-ID: <8736yo29jb.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.18.

Gregory

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.18-1

for you to fetch changes up to 163043ab55210dbb92e36c1220a721f404df6834:

  ARM: dts: armada-xp-98dx: Add NAND pinctrl information (2018-05-18 18:36:57 +0200)

----------------------------------------------------------------
mvebu dt for 4.18 (part 1)

 - Update 32-bit Marvell EBU NAND DT nodes with new bindings
 - Add NAND pinctrl information for the Armada 98DX3236 and variants

----------------------------------------------------------------
Chris Packham (1):
      ARM: dts: armada-xp-98dx: Add NAND pinctrl information

Miquel Raynal (4):
      ARM: dts: armada-370-xp: update NAND node with new bindings
      ARM: dts: armada-375: update NAND node with new bindings
      ARM: dts: armada-38x: update NAND node with new bindings
      ARM: dts: armada-39x: update NAND node with new bindings

 arch/arm/boot/dts/armada-370-db.dts                |  57 ++++----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 120 ++++++++--------
 arch/arm/boot/dts/armada-370-mirabox.dts           |  51 ++++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  90 ++++++------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  90 ++++++------
 arch/arm/boot/dts/armada-370-rd.dts                |  52 ++++---
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  64 +++++----
 arch/arm/boot/dts/armada-370-xp.dtsi               |   6 +-
 arch/arm/boot/dts/armada-375-db.dts                |  50 ++++---
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |  69 ++++-----
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    | 129 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     | 129 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys-rango.dts     | 141 ++++++++++---------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 129 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys.dtsi          |  16 ++-
 arch/arm/boot/dts/armada-388-db.dts                |  55 +++++---
 arch/arm/boot/dts/armada-38x.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-390-db.dts                |  66 +++++----
 arch/arm/boot/dts/armada-395-gp.dts                |  74 +++++-----
 arch/arm/boot/dts/armada-398-db.dts                |  60 ++++----
 arch/arm/boot/dts/armada-39x.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |  13 ++
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 156 +++++++++++----------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  90 ++++++------
 30 files changed, 948 insertions(+), 787 deletions(-)
