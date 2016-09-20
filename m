From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Sep 2016 18:14:47 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.8 (#3)
Message-ID: <87intq5z0o.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for fixes for mvebu for v4.8.

Gregory

The following changes since commit c721da1d05760ad0b4e7670896dae31b6b07d8d6:

  ARM: dts: kirkwood: Fix PCIe label on OpenRD (2016-08-26 11:33:16 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.8-3

for you to fetch changes up to 51227bf52008bd4c4c50da4b749bbc6e7bbbca52:

  arm64: dts: marvell: fix clocksource for CP110 master SPI0 (2016-09-20 16:55:12 +0200)

----------------------------------------------------------------
mvebu fixes for 4.8 (part 3)

- Select corediv clk for all mvebu v7 SoC
- Fix clocksource for CP110 master SPI0 for Armada 7K/8K

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Select corediv clk for all mvebu v7 SoC

Marcin Wojtas (1):
      arm64: dts: marvell: fix clocksource for CP110 master SPI0

 arch/arm/mach-mvebu/Kconfig                          | 4 +---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)
