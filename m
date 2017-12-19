From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Dec 2017 11:45:53 +0530
Subject: [GIT PULL] TI DaVinci fixes for v4.15
Message-ID: <7d86583e-a4e7-fd44-3caf-9bfa7e1a1491@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.15

for you to fetch changes up to 451df7d110b82998c04a80d0de0f1e79aaa7792a:

  ARM: davinci: fix mmc entries in dm365's dma_slave_map (2017-12-08 16:12:21 +0530)

----------------------------------------------------------------
DaVinci fixes for v4.15 consiting of fixes to make EDMA and MMC/SD
work on DM365 and a fix for battery voltage monitoring on Lego EV3.

----------------------------------------------------------------
Alejandro Mery (3):
      ARM: davinci: Use platform_device_register_full() to create pdev for dm365's eDMA
      ARM: davinci: Add dma_mask to dm365's eDMA device
      ARM: davinci: fix mmc entries in dm365's dma_slave_map

David Lechner (1):
      ARM: dts: da850-lego-ev3: Fix battery voltage gpio

 arch/arm/boot/dts/da850-lego-ev3.dts |  4 ++--
 arch/arm/mach-davinci/dm365.c        | 29 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 13 deletions(-)
