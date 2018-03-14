From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 17:19:22 +0100
Subject: [PATCH 0/6] Add the registers clock for most of the peripherals
Message-ID: <20180314161928.7239-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks to new documentation, we have a better view of the clock
tree. It made us realized that most of the peripherals needs a second
clock to enable their registers.

Now that most of the binding change had been applied or are in the way
to be applied, we can update the device tree.

Gregory

Gregory CLEMENT (6):
  ARM64: dts: marvell: armada-cp110: Add registers clock for USB host
    nodes
  ARM64: dts: marvell: armada-cp110: Add registers clock for XOR engine
    nodes
  ARM64: dts: marvell: armada-cp110: Add registers clock for the trng
    node
  ARM64: dts: marvell: armada-cp110: Add registers clock for the crypto
    node
  ARM64: dts: marvell: armada-cp110: Add registers clock for the NAND
    node
  ARM64: dts: marvell: armada-cp110: Add registers clock for the PCIe
    nodes

 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 37 +++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

-- 
2.16.1
