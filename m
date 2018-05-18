From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 May 2018 18:50:21 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.18 (#1)
Message-ID: <871se829iq.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.18.

Gregory

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.18-1

for you to fetch changes up to bd473ecda24c6214868d58500c4d7569f6597946:

  arm64: dts: marvell: armada-37xx: mark the gpio controllers as irq controller (2018-05-18 18:35:16 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.18 (part 1)

 - Allow using Armada 3700 gpio controller as interrupt one too
 - Describe SPI flash on the EspressoBin
 - Mark ahci as dma-coherent for Armada 7K/8K
 - Add 10G interface support Armada 7K/8K based boards (including MacBin)

----------------------------------------------------------------
Antoine Tenart (3):
      arm64: dts: marvell: mcbin: enable the fourth network interface
      arm64: dts: marvell: 8040-db: describe the 10G interfaces as fixed-link
      arm64: dts: marvell: 7040-db: describe the 10G interface as fixed-link

Ellie Reeves (1):
      arm64: dts: armada-3720-espressobin: wire up spi flash

Mark Kettenis (1):
      arm64: dts: marvell: mark CP110 ahci as dma-coherent

Russell King (1):
      arm64: dts: marvell: mcbin: add 10G SFP support

Uwe Kleine-K?nig (1):
      arm64: dts: marvell: armada-37xx: mark the gpio controllers as irq controller

 .../boot/dts/marvell/armada-3720-espressobin.dts   | 27 +++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  6 ++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  5 ++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 10 ++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 70 ++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  1 +
 6 files changed, 119 insertions(+)
