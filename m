From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jun 2017 18:51:21 +0200
Subject: [PATCH 0/4] Update device tree for Armada 3720 DB
Message-ID: <20170608165125.27630-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the main purpose of this short series is to add the support of the
second SDHCI controller on the Armada 3720 DB board (and on the Armada
37xx SoC).

This series also adds some improvement to the device tree of the the
Armada 3720 DB board and the last patch allow using higher speed on
the SD card by adding the vqmmc regulator.

Gregory

Gregory CLEMENT (3):
  arm64: dts: marvell: armada-3720-db: Sort the dts node alphabetically
  arm64: dts: marvell: armada-3720-db: Add information about the V2
    board
  arm64: dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot

Konstantin Porotchkin (1):
  arm64: dts: marvell: Enable second SDHCI controller in Armada 37xx

 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 120 ++++++++++++++++---------
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  11 +++
 2 files changed, 87 insertions(+), 44 deletions(-)

-- 
2.11.0
