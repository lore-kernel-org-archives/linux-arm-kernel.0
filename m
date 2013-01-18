From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Jan 2013 21:02:16 +0530
Subject: [PATCH 0/5] ARM: OMAP5: Misc fixes
Message-ID: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series contains few random fixes needed for OMAP5 es2.0 boot going.
There is no depedency with data files for this series and can be
applied indepedently.

Tested on OMAP5 uEVM and sEVM boards.


The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://github.com/SantoshShilimkar/linux.git for_3.9/omap5_misc_fixes

for you to fetch changes up to 4bedcaba7da88d06cde60aa595dfe57ddd8495cc:

  ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer (2013-01-18 20:47:42 +0530)

----------------------------------------------------------------

Rajendra Nayak (1):
  ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer

Santosh Shilimkar (4):
  ARM: OMAP5: Update SOC id detection code for ES2
  ARM: OMAP2+: timer: Update the OMAP5 clocksource name as per clock
    data
  ARM: OMAP: prm: Allow prm init to success on OMAP5 SOCs
  ARM: dts: omap5-evm: Update available memory to 2032 MB

 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 arch/arm/boot/dts/omap5.dtsi    |   16 ++++++++++++----
 arch/arm/mach-omap2/id.c        |   16 +++++++++++++---
 arch/arm/mach-omap2/prm44xx.c   |    2 +-
 arch/arm/mach-omap2/soc.h       |    2 ++
 arch/arm/mach-omap2/timer.c     |    5 +++--
 6 files changed, 32 insertions(+), 11 deletions(-)

-- 
1.7.9.5
