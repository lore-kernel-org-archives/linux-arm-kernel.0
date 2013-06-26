From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 26 Jun 2013 15:08:48 +0200
Subject: [PATCH 1/2] ARM i.MX6Q: Fix IOMUXC GPR1 defines for ENET_CLK_SEL and
 IPU1/2_MUX
Message-ID: <1372252129-18898-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index dab34a1..b1521e8 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -103,15 +103,15 @@
 #define IMX6Q_GPR1_EXC_MON_MASK			BIT(22)
 #define IMX6Q_GPR1_EXC_MON_OKAY			0x0
 #define IMX6Q_GPR1_EXC_MON_SLVE			BIT(22)
-#define IMX6Q_GPR1_MIPI_IPU2_SEL_MASK		BIT(21)
-#define IMX6Q_GPR1_MIPI_IPU2_SEL_GASKET		0x0
-#define IMX6Q_GPR1_MIPI_IPU2_SEL_IOMUX		BIT(21)
-#define IMX6Q_GPR1_MIPI_IPU1_MUX_MASK		BIT(20)
-#define IMX6Q_GPR1_MIPI_IPU1_MUX_GASKET		0x0
-#define IMX6Q_GPR1_MIPI_IPU1_MUX_IOMUX		BIT(20)
-#define IMX6Q_GPR1_MIPI_IPU2_MUX_MASK		BIT(19)
+#define IMX6Q_GPR1_ENET_CLK_SEL_MASK		BIT(21)
+#define IMX6Q_GPR1_ENET_CLK_SEL_PAD		0
+#define IMX6Q_GPR1_ENET_CLK_SEL_ANATOP		BIT(21)
+#define IMX6Q_GPR1_MIPI_IPU2_MUX_MASK		BIT(20)
 #define IMX6Q_GPR1_MIPI_IPU2_MUX_GASKET		0x0
-#define IMX6Q_GPR1_MIPI_IPU2_MUX_IOMUX		BIT(19)
+#define IMX6Q_GPR1_MIPI_IPU2_MUX_IOMUX		BIT(20)
+#define IMX6Q_GPR1_MIPI_IPU1_MUX_MASK		BIT(19)
+#define IMX6Q_GPR1_MIPI_IPU1_MUX_GASKET		0x0
+#define IMX6Q_GPR1_MIPI_IPU1_MUX_IOMUX		BIT(19)
 #define IMX6Q_GPR1_PCIE_TEST_PD			BIT(18)
 #define IMX6Q_GPR1_IPU_VPU_MUX_MASK		BIT(17)
 #define IMX6Q_GPR1_IPU_VPU_MUX_IPU1		0x0
-- 
1.8.3.1
