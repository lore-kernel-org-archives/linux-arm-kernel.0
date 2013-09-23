From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 23 Sep 2013 10:20:32 -0700
Subject: [PATCH v2 0/4] ARCH_BCM rename
Message-ID: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename ARCH_BCM to ARCH_BCM_MOBILE. Currently only the 
Broadcom mobile SoCs reside in the mach-bcm directory and are 
chosen by the ARCH_BCM config option.
 This patchset changes so that ARCH_BCM becomes a menu select
for Broadcom ARM SoCs. ARCH_BCM_MOBILE is created to signify 
the (multiplatform) Mobile SoCs.

Christian Daudt (4):
  rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
  rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
  rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
  rename ARCH_BCM to ARCH_BCM_MOBILE (dt)

 arch/arm/boot/dts/Makefile          |    4 ++--
 arch/arm/configs/bcm_defconfig      |    1 +
 arch/arm/configs/multi_v7_defconfig |    1 +
 arch/arm/mach-bcm/Kconfig           |   20 ++++++++++++++++++--
 arch/arm/mach-bcm/Makefile          |    2 +-
 drivers/clocksource/Makefile        |    2 +-
 drivers/mmc/host/Kconfig            |    2 +-
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.7.10.4
