From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:25 +0800
Subject: [PATCH RFC v9 02/20] ARM: imx6q: Add GPR3 MIPI muxing control
 register field shift bits definition
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423720903-24806-3-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a macro to define the GPR3 MIPI muxing control register field
shift bits.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v8->v9:
 * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.

v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * None.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * None.

v1->v2:
 * None.

 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index c877cad..d16f4c8 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -207,6 +207,7 @@
 #define IMX6Q_GPR3_LVDS0_MUX_CTL_IPU1_DI1	(0x1 << 6)
 #define IMX6Q_GPR3_LVDS0_MUX_CTL_IPU2_DI0	(0x2 << 6)
 #define IMX6Q_GPR3_LVDS0_MUX_CTL_IPU2_DI1	(0x3 << 6)
+#define IMX6Q_GPR3_MIPI_MUX_CTL_SHIFT		4
 #define IMX6Q_GPR3_MIPI_MUX_CTL_MASK		(0x3 << 4)
 #define IMX6Q_GPR3_MIPI_MUX_CTL_IPU1_DI0	(0x0 << 4)
 #define IMX6Q_GPR3_MIPI_MUX_CTL_IPU1_DI1	(0x1 << 4)
-- 
2.1.0
