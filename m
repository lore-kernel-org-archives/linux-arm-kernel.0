From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 12 Jan 2017 10:59:01 -0300
Subject: [PATCH] usb: dwc3: exynos: Remove MODULE_ALIAS()
Message-ID: <1484229541-21469-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos is DT-only, so there's no need for a platform MODALIAS.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/usb/dwc3/dwc3-exynos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index e27899bb5706..2e555a69c8ab 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -288,7 +288,6 @@ static struct platform_driver dwc3_exynos_driver = {
 
 module_platform_driver(dwc3_exynos_driver);
 
-MODULE_ALIAS("platform:exynos-dwc3");
 MODULE_AUTHOR("Anton Tikhomirov <av.tikhomirov@samsung.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DesignWare USB3 EXYNOS Glue Layer");
-- 
2.7.4
