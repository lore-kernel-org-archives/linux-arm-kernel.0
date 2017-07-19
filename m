From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Jul 2017 17:31:24 +0200
Subject: [PATCH 0/2] Enable NAND support on Armada 7K/8K
Message-ID: <20170719153126.16905-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

this short series enables the NAND controller on the Armada 7K/8K
SoCs. The IP used is the same that the other mvebu SoC, so we only
need to be bale to build it for this SoCs and updating the device
tree.

The first patch should go to mtd and the second one to arm-soc through
mvebu.

The patches are completely independent.

Thanks,

Gregory

Gregory CLEMENT (2):
  mtd: nand: pxa3xx_nand: enable building on mvebu 64-bit platforms
  ARM64: dts: marvell: add NAND support on the CP110 master

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 14 ++++++++++++++
 drivers/mtd/nand/Kconfig                             |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.13.2
