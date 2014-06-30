From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:06 +0300
Subject: [PATCH 3/6] ARM: s3c24xx: h1940: Add DMA device
In-Reply-To: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
References: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1404156009-3919-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a corresponding device for a new dmaengine driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/mach-h1940.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index fbf5487..cf36f26 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -623,6 +623,7 @@ static struct platform_device h1940_dev_buttons = {
 
 static struct platform_device *h1940_devices[] __initdata = {
 	&h1940_dev_buttons,
+	&s3c2410_device_dma,
 	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
-- 
2.0.0
