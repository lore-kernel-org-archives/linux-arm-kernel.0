From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jul 2018 16:02:53 +1200
Subject: [PATCH 0/4] ARM: dts: mvebu: updates and new board
Message-ID: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the armada-xp-98dx3236 SoC and related boards to use the
new style dts bindings for nand.

I've also added a new db-88f6820-amc board which is an Armada-385 based
reference board from Marvell's switch team. It's a plugin card for either the
db-dxbc2 or db-xc3-24g4 which can be used if you disable the internal CPU on
those platforms.

Chris Packham (4):
  ARM: dts: mvebu: 98dx3236: Rename nand controller node
  ARM: dts: mvebu: db-dxbc2: use new style nand binding
  ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
  ARM: dts: mvebu: Add device tree for db-88f6820-amc board

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/armada-385-db-88f6820-amc.dts    | 184 ++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |  18 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |  18 +-
 5 files changed, 208 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts

-- 
2.18.0
