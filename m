From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:27:14 +0900
Subject: [PATCH 02/12] [ARM][S3C6410] Kconfig support to select keypad platform
	device
Message-ID: <00a401ca2e2c$94f65210$bee2f630$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports Kconfig to select keypad platform device compile.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-s3c6410/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c6410/Kconfig
index e63aac7..fc651e2 100644
--- a/arch/arm/mach-s3c6410/Kconfig
+++ b/arch/arm/mach-s3c6410/Kconfig
@@ -37,6 +37,7 @@ config MACH_SMDK6410
 	select S3C_DEV_FB
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
+	select S3C_DEV_KEYPAD
 	select S3C6410_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
-- 
1.6.2.5
