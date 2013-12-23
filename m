From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 23 Dec 2013 22:03:51 +0800
Subject: [PATCH] MAINTAINERS: ARM: SiRF: add sirf UART and watchdog to
 maintain list
Message-ID: <1387807431-3547-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

take CSR serial and watchdog drivers into maintain list.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5e4ff3..b9a1173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -858,6 +858,8 @@ F:	drivers/mmc/host/sdhci-sirf.c
 F:	drivers/pinctrl/sirf/
 F:	drivers/rtc/rtc-sirfsoc.c
 F:	drivers/spi/spi-sirf.c
+F:	drivers/tty/serial/sirfsoc_uart.*
+F:	drivers/watchdog/sirfsoc_wdt.c
 
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
-- 
1.7.5.4
