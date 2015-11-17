From: Zhiqiang.Hou@freescale.com (Zhiqiang Hou)
Date: Tue, 17 Nov 2015 17:53:19 +0800
Subject: [PATCHv8 2/5] watchdog: Add support for Freescale Layerscape platforms
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Message-ID: <1447754002-40555-2-git-send-email-Zhiqiang.Hou@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify watchdog/Kconfig file to support Layerscape platforms.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
V8:
 - No change.

V6:
 - Remove a Signed-off.

V5: V4 V3 V2
 - No change.

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7a8a6c6..1c427be 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
-- 
2.1.0.27.g96db324
