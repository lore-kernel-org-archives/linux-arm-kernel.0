From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Aug 2011 23:41:38 +0900
Subject: [PATCH] ARM: S3C64XX: Remove unused CPU devices for Cragganmore
Message-ID: <1313419298-28777-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 7e84ad7..da3d840 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -350,9 +350,6 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
-	&s3c_device_adc,
-	&s3c_device_rtc,
-	&s3c_device_ts,
 	&s3c_device_timer[0],
 	&s3c64xx_device_iis0,
 	&s3c64xx_device_iis1,
-- 
1.7.5.4
