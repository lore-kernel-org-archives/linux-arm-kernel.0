From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 10:39:33 +0000
Subject: [PATCH] ARM: S3C2412: Fixup commented out device in SMDK2413
In-Reply-To: <1263551977-15090-1-git-send-email-ben-linux@fluff.org>
References: <1263551977-15090-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263551977-15090-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMDK2413 has a commented out device that does not have any setup
data for it, so remove it for now.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2412/mach-smdk2413.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index 437c087..0392065 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -105,7 +105,6 @@ static struct s3c2410_udc_mach_info smdk2413_udc_cfg __initdata = {
 
 static struct platform_device *smdk2413_devices[] __initdata = {
 	&s3c_device_ohci,
-	//&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
-- 
1.6.0.4
