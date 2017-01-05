From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:45 +0100
Subject: [PATCH 0/6] ARM: dts: phyBOARD-WEGA-AM335x updates
Message-ID: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set of small patches to update the device tree of the
phyCORE-AM335x SOM and phyBOARD-WEGA-AM335x.

Teresa Remmet (6):
  ARM: dts: am335x-phycore-som: Update NAND partition table
  ARM: dts: am335x-phycore-som: Update compatible string for spi nor
  ARM: dts: am335x-phycore-som: Add i2c temp sensor
  ARM: dts: am335x-wega: Set USB0 mode to otg
  ARM: dts: am335x-phycore-som: Update ethernet phy node
  ARM: dts: am335x-wega: Update ethernet phy node

 arch/arm/boot/dts/am335x-phycore-som.dtsi | 30 +++++++++++++++++++-----------
 arch/arm/boot/dts/am335x-wega.dtsi        |  9 +++++++--
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
1.9.1
