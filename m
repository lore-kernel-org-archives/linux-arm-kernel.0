From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  7 Oct 2018 21:24:17 +0800
Subject: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Message-ID: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to newly added IMX SCU firmware support, let's add
drivers/firmware/imx into maintainership.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052a..d1fb824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1462,6 +1462,7 @@ F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
 F:	drivers/clk/imx/
+F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
 F:	include/soc/imx/
 
-- 
2.7.4
