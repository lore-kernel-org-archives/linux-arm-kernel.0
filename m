From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Mar 2018 17:50:31 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.17 (#2)
Message-ID: <87lgeoxb54.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.17.

Gregory

The following changes since commit 597667d889517c6085d57aac92dbf1cc624cd8ae:

  ARM64: dts: marvell: armada-cp110: Add apb_pclk clock for the uart nodes (2018-03-09 17:49:46 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.17-2

for you to fetch changes up to 003456f564205ca3c3b8b4c9f9c22a0846d81fd7:

  arm64: dts: armada-3720-espressobin: Document URL for schematic (2018-03-19 17:19:24 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.17 (part 2)

- Add registers clock for all the peripheral nodes that had been yet
  converted for CP110 (Armada 7K/8K)

- Document URL for schematic for the EspressoBin (Armada 3720)

----------------------------------------------------------------
Gregory CLEMENT (6):
      ARM64: dts: marvell: armada-cp110: Add registers clock for USB host nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for XOR engine nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for the trng node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the crypto node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the NAND node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the PCIe nodes

Uwe Kleine-K?nig (1):
      arm64: dts: armada-3720-espressobin: Document URL for schematic

 .../boot/dts/marvell/armada-3720-espressobin.dts   |  3 ++
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 37 ++++++++++++++++------
 2 files changed, 30 insertions(+), 10 deletions(-)
