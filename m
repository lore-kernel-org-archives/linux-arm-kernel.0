From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 8 Nov 2013 12:44:46 -0800
Subject: [PATCH 0/2] watchdog: bcm281xx: Watchdog Driver
Message-ID: <1383943488-6537-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces the watchdog driver for the BCM281xx family of
mobile SoCs.

Markus Mayer (2):
  watchdog: bcm281xx: Watchdog Driver
  ARM: bcm281xx: watchdog configuration

 arch/arm/configs/bcm_defconfig  |    3 +
 drivers/watchdog/Kconfig        |   21 +++
 drivers/watchdog/Makefile       |    1 +
 drivers/watchdog/bcm_kona_wdt.c |  399 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 424 insertions(+)
 create mode 100644 drivers/watchdog/bcm_kona_wdt.c

-- 
1.7.9.5
