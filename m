From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun,  5 Mar 2017 17:32:40 -0800
Subject: [GIT PULL] Broadcom devicetree fixes for 4.11
Message-ID: <20170306013240.21734-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree-fixes

for you to fetch changes up to 0c2bf9f95983fe30aa2f6463cb761cd42c2d521a:

  ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags (2017-03-05 17:10:55 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree fixes for 4.11,
please pull the following:

- Jon fixes the UART output on the Broadcom bcm953012k reference board by
  using the proper clock reference instead of hard-coding the baud rate

- Jon also fixes the memory map on the bcm953012k reference board by using
  the appropriate physical RAM start address

- Jon finally fixes the interrupt type for the Cortex A9 global and local
  timers found in the BCM5301X SoC (Norsthar).

----------------------------------------------------------------
Jon Mason (3):
      ARM: dts: BCM5301X: Fix UARTs on bcm953012k
      ARM: dts: BCM5301X: Fix memory start address
      ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags

 arch/arm/boot/dts/bcm5301x.dtsi  | 4 ++--
 arch/arm/boot/dts/bcm953012k.dts | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)
