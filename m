From: marek.belisko@gmail.com (Marek Belisko)
Date: Tue,  9 Nov 2010 14:22:47 +0100
Subject: [PATCH] ARM: s3c2440: mini2440: Add selection of touchscreen.
Message-ID: <1289308967-14520-1-git-send-email-marek.belisko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add selection of touchscreen driver by default
when use mini2440 board.

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 arch/arm/mach-s3c2440/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index ff024a6..d4a33fb 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -181,6 +181,7 @@ config MACH_MINI2440
 	select LEDS_TRIGGER_BACKLIGHT
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
+	select TOUCHSCREEN_S3C2410
 	help
 	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
 	  available via various sources. It can come with a 3.5" or 7" touch LCD.
-- 
1.7.1
