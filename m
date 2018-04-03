From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 3 Apr 2018 18:06:51 +0800
Subject: [PATCH 3/3] mmc: meson: update doc to support Meson-AXG platform
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
Message-ID: <20180403100652.41056-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nan Li <nan.li@amlogic.com>

Explicitly update the docomentation to support the Meson-AXG platform.

Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/mmc/host/Kconfig        | 4 ++--
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d90a646..751090d1d94c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -345,11 +345,11 @@ config MMC_SDHCI_IPROC
 	  If unsure, say N.
 
 config MMC_MESON_GX
-	tristate "Amlogic S905/GX* SD/MMC Host Controller support"
+	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
 	depends on ARCH_MESON && MMC
 	help
 	  This selects support for the Amlogic SD/MMC Host Controller
-	  found on the S905/GX* family of SoCs.  This controller is
+	  found on the S905/GX*/AXG family of SoCs.  This controller is
 	  MMC 5.1 compliant and supports SD, eMMC and SDIO interfaces.
 
 	  If you have a controller with this interface, say Y here.
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 56c90542ac29..55bbd67177df 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1376,6 +1376,6 @@ static struct platform_driver meson_mmc_driver = {
 
 module_platform_driver(meson_mmc_driver);
 
-MODULE_DESCRIPTION("Amlogic S905*/GX* SD/eMMC driver");
+MODULE_DESCRIPTION("Amlogic S905*/GX*/AXG SD/eMMC driver");
 MODULE_AUTHOR("Kevin Hilman <khilman@baylibre.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.16.2
