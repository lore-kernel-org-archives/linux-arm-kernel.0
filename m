From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 29 Aug 2012 11:05:26 +0200
Subject: [PATCH] MAINTAINERS: add defconfig file to IMX section
Message-ID: <1346231126-11286-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39d8a59..6bfd2df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -777,6 +777,7 @@ S:	Maintained
 T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
 F:	arch/arm/mach-imx/
 F:	arch/arm/plat-mxc/
+F:	arch/arm/configs/imx*_defconfig
 
 ARM/FREESCALE IMX6
 M:	Shawn Guo <shawn.guo@linaro.org>
-- 
1.7.10.4
