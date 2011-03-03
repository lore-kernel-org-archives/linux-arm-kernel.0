From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  3 Mar 2011 14:58:29 +0000
Subject: [PATCH 1/7] ARM: SAMSUNG: Include devs.h in dev-uart.c to prototype
	devices
In-Reply-To: <20110303145710.GA32234@opensource.wolfsonmicro.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
Message-ID: <1299164315-22246-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensures that the declaration agrees with the definition and makes sparse
happy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/dev-uart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
index 3776cd9..5928105 100644
--- a/arch/arm/plat-samsung/dev-uart.c
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+#include <plat/devs.h>
+
 /* uart devices */
 
 static struct platform_device s3c24xx_uart_device0 = {
-- 
1.7.2.3
