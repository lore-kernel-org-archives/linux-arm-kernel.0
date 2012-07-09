From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Mon, 9 Jul 2012 12:39:36 +0800
Subject: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and changes
 for the current watchdog framework
Message-ID: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following patches based on the 3.5-rc6 from Wim, which
are based on:

1 ) bootstatus fix for omap3,

2 ) omap-wdt framework update cater for the current framework
    as Shubhrajyoti comments mentioned.

Regards,
Zumeng

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

Zumeng Chen (3):
      Watchdog: Omap: Changes for the new watchdog framework
      Watchdog: Omap: select watchdog core for framework change
      Watchdog: Omap: get the bootstatus for OMAP2Plus

 arch/arm/mach-omap2/prcm.c  |    5 +-
 drivers/watchdog/Kconfig    |    1 +
 drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------------------
 drivers/watchdog/omap_wdt.h |    5 +
 4 files changed, 133 insertions(+), 216 deletions(-)
