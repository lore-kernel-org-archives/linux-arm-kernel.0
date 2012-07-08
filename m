From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:19 +0200
Subject: [PATCH 05/10] MACH/Samsung/Mini2440: select touchscreen by default.
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-6-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Belisko <marek.belisko@open-nandra.com>

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
Acked-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-s3c24xx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index e249611..0e65445 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -405,6 +405,7 @@ config MACH_MINI2440
 	select LEDS_TRIGGER_BACKLIGHT
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
+	select TOUCHSCREEN_S3C2410
 	help
 	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
 	  available via various sources. It can come with a 3.5" or 7" touch LCD.
-- 
1.7.10
