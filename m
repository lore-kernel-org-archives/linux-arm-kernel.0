From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Jul 2014 22:37:03 +0200
Subject: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
Message-ID: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
identical; if not, feel free to nack this series.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  serial: DC21285: depend on ARCH_FOOTBRIDGE instead of FOOTBRIDGE
  watchdog: get rid of FOOTBRIDGE in dependencies
  ARM: drop Kconfig symbol FOOTBRIDGE

 arch/arm/Kconfig                 |  1 -
 arch/arm/Kconfig.debug           | 14 +++++++-------
 arch/arm/mach-footbridge/Kconfig |  4 ----
 drivers/tty/serial/Kconfig       |  2 +-
 drivers/watchdog/Kconfig         |  4 ++--
 5 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.0.0
