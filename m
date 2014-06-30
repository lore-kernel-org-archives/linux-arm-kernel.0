From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:09 +0300
Subject: [PATCH 6/6] ARM: s3c24xx: RX1950: Add DMA device
In-Reply-To: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
References: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1404156009-3919-6-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a corresponding device for a new dmaengine driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/mach-rx1950.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e2c6541..95b88a6 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -710,6 +710,7 @@ static struct i2c_board_info rx1950_i2c_devices[] = {
 
 static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c2410_device_dclk,
+	&s3c2410_device_dma,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
-- 
2.0.0
