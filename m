From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon,  8 Oct 2018 18:25:07 +0800
Subject: [PATCH V2 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Message-ID: <1538994307-8621-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to newly added IMX SCU firmware support, let's add
drivers/firmware/imx into maintainership.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2:
 * add missing include/linux/firmware/imx
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052a..eee17f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1462,7 +1462,9 @@ F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
 F:	drivers/clk/imx/
+F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
+F:	include/linux/firmware/imx/
 F:	include/soc/imx/
 
 ARM/FREESCALE VYBRID ARM ARCHITECTURE
-- 
2.7.4
