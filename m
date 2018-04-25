From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Apr 2018 16:47:58 +0200
Subject: [PATCH v2 0/4] Update 32-bit Marvell EBU NAND DT nodes with new
 bindings
Message-ID: <20180425144802.15998-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of a previous work, the bindings for the Marvell NAND controller
have changed and various DT got updated accordingly. I asked Gregory not
to take the DT patches updating the NAND nodes of the 32-bit Marvell EBU
platforms from the last series because of the need to update one
property after a review from Rob Herring.

My apologies to this very late new version of the patches, they are now
ready to be merged.

Thank you,
Miqu?l

Changes since v1
================
* s/marvell,rb/nand-rb/ DT property.
* Reworded a bit the commit messages.


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
 arch/arm/boot/dts/armada-375-db.dts                |  48 ++++---
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |  69 ++++-----
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    | 127 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     | 127 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys-rango.dts     | 119 ++++++++--------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 127 +++++++++--------
 arch/arm/boot/dts/armada-385-linksys.dtsi          |  16 ++-
 arch/arm/boot/dts/armada-388-db.dts                |  55 +++++---
 arch/arm/boot/dts/armada-38x.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-390-db.dts                |  66 +++++----
 arch/arm/boot/dts/armada-395-gp.dts                |  74 +++++-----
 arch/arm/boot/dts/armada-398-db.dts                |  60 ++++----
 arch/arm/boot/dts/armada-39x.dtsi                  |   6 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 156 +++++++++++----------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  90 ++++++------
 29 files changed, 920 insertions(+), 772 deletions(-)

-- 
2.14.1
