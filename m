From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 11 Oct 2015 22:40:42 +0200
Subject: [PATCH] MAINTAINERS: update lpc18xx entry with more drivers
In-Reply-To: <1444596042-31904-1-git-send-email-manabian@gmail.com>
References: <1444596042-31904-1-git-send-email-manabian@gmail.com>
Message-ID: <1444596042-31904-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add explicit entries for drivers used by the lpc18xx that is
not caught by the "lpc18xx" regex pattern.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi arm-soc team,

Please apply this update to MAINTAINERS for lpc18xx.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab749c85..52ddb8cc0119 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1224,6 +1224,13 @@ ARM/LPC18XX ARCHITECTURE
 M:	Joachim Eastwood <manabian@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/dts/lpc43*
+F:	drivers/clk/nxp/clk-lpc18xx*
+F:	drivers/clocksource/time-lpc32xx.c
+F:	drivers/i2c/busses/i2c-lpc2k.c
+F:	drivers/memory/pl172.c
+F:	drivers/mtd/spi-nor/nxp-spifi.c
+F:	drivers/rtc/rtc-lpc24xx.c
 N:	lpc18xx
 
 ARM/MAGICIAN MACHINE SUPPORT
-- 
1.8.0
