From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 15:09:58 +0200
Subject: [PATCH 1/2] ARM: imx6q: Add GPR6 and GPR7 register definitions for
 iomuxc gpr
Message-ID: <1369919399-24370-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Masks for IPU AXI transaction QoS settings

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index dab34a1..2e1709b 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -241,6 +241,24 @@
 
 #define IMX6Q_GPR5_L2_CLK_STOP			BIT(8)
 
+#define IMX6Q_GPR6_IPU1_ID00_WR_QOS_MASK	(0xf << 0)
+#define IMX6Q_GPR6_IPU1_ID01_WR_QOS_MASK	(0xf << 4)
+#define IMX6Q_GPR6_IPU1_ID10_WR_QOS_MASK	(0xf << 8)
+#define IMX6Q_GPR6_IPU1_ID11_WR_QOS_MASK	(0xf << 12)
+#define IMX6Q_GPR6_IPU1_ID00_RD_QOS_MASK	(0xf << 16)
+#define IMX6Q_GPR6_IPU1_ID01_RD_QOS_MASK	(0xf << 20)
+#define IMX6Q_GPR6_IPU1_ID10_RD_QOS_MASK	(0xf << 24)
+#define IMX6Q_GPR6_IPU1_ID11_RD_QOS_MASK	(0xf << 28)
+
+#define IMX6Q_GPR7_IPU2_ID00_WR_QOS_MASK	(0xf << 0)
+#define IMX6Q_GPR7_IPU2_ID01_WR_QOS_MASK	(0xf << 4)
+#define IMX6Q_GPR7_IPU2_ID10_WR_QOS_MASK	(0xf << 8)
+#define IMX6Q_GPR7_IPU2_ID11_WR_QOS_MASK	(0xf << 12)
+#define IMX6Q_GPR7_IPU2_ID00_RD_QOS_MASK	(0xf << 16)
+#define IMX6Q_GPR7_IPU2_ID01_RD_QOS_MASK	(0xf << 20)
+#define IMX6Q_GPR7_IPU2_ID10_RD_QOS_MASK	(0xf << 24)
+#define IMX6Q_GPR7_IPU2_ID11_RD_QOS_MASK	(0xf << 28)
+
 #define IMX6Q_GPR9_TZASC2_BYP			BIT(1)
 #define IMX6Q_GPR9_TZASC1_BYP			BIT(0)
 
-- 
1.8.2.1
