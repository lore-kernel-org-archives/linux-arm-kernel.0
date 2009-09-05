From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:30:14 +0900
Subject: [PATCH 10/12] [ARM][S3C6410] Add support to register keypad platform
	device
Message-ID: <00a601ca2e2d$00237450$006a5cf0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports platform device registration for keypad device.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index bc9a7de..fb2b138 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -184,6 +184,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
+	&s3c_device_keypad,
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
-- 
1.6.2.5
