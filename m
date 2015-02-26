From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:21 +0900
Subject: [PATCH 2/5] drivers: bus: Sort Makefile entries alphabetically
In-Reply-To: <cover.1424931637.git.horms+renesas@verge.net.au>
References: <cover.1424931637.git.horms+renesas@verge.net.au>
Message-ID: <6320c41198c76f799e3e34da48a1f2a88ef4cc68.1424931637.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/bus/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 2973c18..3cfaf2c 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -2,16 +2,16 @@
 # Makefile for the bus drivers.
 #
 
+# Interconnect bus drivers for ARM platforms
+obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
+obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
+
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
-obj-$(CONFIG_IMX_WEIM)	+= imx-weim.o
-obj-$(CONFIG_MVEBU_MBUS) += mvebu-mbus.o
-obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
+obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
+obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
-# Interconnect bus drivers for ARM platforms
-obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
-obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
-
+obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
-- 
2.1.4
