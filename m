From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Mar 2014 15:42:13 -0700
Subject: [GIT PULL] omap fixes for v3.15 merge window
Message-ID: <20140313224213.GA27402@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-for-merge-window

for you to fetch changes up to 77319669af37a1cfc844b801e83343b37e3c7e13:

  ARM: OMAP4: hwmod data: correct the idlemodes for spinlock (2014-03-13 14:09:57 -0700)

----------------------------------------------------------------
Fixes for omaps that would be good to get in before v3.15-rc1.

----------------------------------------------------------------
Florian Vaussard (2):
      CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy clocks
      ARM: dts: omap4/5: Use l3_ick for the gpmc node

Mugunthan V N (1):
      ARM: dts: am33xx: correcting dt node unit address for usb

Nishanth Menon (1):
      ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM

Stefan S??rensen (1):
      ARM: OMAP2+: INTC: Acknowledge stuck active interrupts

Suman Anna (1):
      ARM: OMAP4: hwmod data: correct the idlemodes for spinlock

 arch/arm/boot/dts/am33xx.dtsi              | 4 ++--
 arch/arm/boot/dts/omap4.dtsi               | 2 ++
 arch/arm/boot/dts/omap5.dtsi               | 2 ++
 arch/arm/mach-omap2/irq.c                  | 8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3 +--
 arch/arm/mach-omap2/pm.h                   | 2 +-
 drivers/clk/ti/clk-44xx.c                  | 1 -
 drivers/clk/ti/clk-54xx.c                  | 1 -
 drivers/clk/ti/clk-7xx.c                   | 1 -
 9 files changed, 16 insertions(+), 8 deletions(-)
