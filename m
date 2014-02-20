From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 20 Feb 2014 12:44:32 +0100
Subject: [RFC PATCH 1/2] ARM: imx6q: Add GPR6 and GPR7 register definitions
 for iomuxc gpr
Message-ID: <1392896673-13627-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masks for IPU AXI transaction QoS settings

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 866e355..ff44374 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -242,6 +242,24 @@
 
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
 #define IMX6Q_GPR8_TX_SWING_LOW			(0x7f << 25)
 #define IMX6Q_GPR8_TX_SWING_FULL		(0x7f << 18)
 #define IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB		(0x3f << 12)
-- 
1.8.5.3
