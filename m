From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  2 Mar 2011 10:04:04 +0000
Subject: [PATCH] ARM: SAMSUNG: Include devs.h in dev-uart.c to prototype
	devices
Message-ID: <1299060244-22710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensures that the declaration agrees with the definition and makes sparse
happy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/dev-uart.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
index 5928105..3776cd9 100644
--- a/arch/arm/plat-samsung/dev-uart.c
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -15,8 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#include <plat/devs.h>
-
 /* uart devices */
 
 static struct platform_device s3c24xx_uart_device0 = {
-- 
1.7.2.3
