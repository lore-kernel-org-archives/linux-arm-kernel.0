From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 11 Jul 2014 17:18:28 +0300
Subject: [PATCH 3/8] ARM: tegra: Add PLL_M_UD and PLL_C_UD to tegra124-car
 binding header
In-Reply-To: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1405088313-20048-4-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add these clocks to the binding header so that EMC timings that have
them as parent can refer to the clocks.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 include/dt-bindings/clock/tegra124-car.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/tegra124-car.h b/include/dt-bindings/clock/tegra124-car.h
index 4faabce..f58b24d 100644
--- a/include/dt-bindings/clock/tegra124-car.h
+++ b/include/dt-bindings/clock/tegra124-car.h
@@ -337,6 +337,10 @@
 #define TEGRA124_CLK_DSIB_MUX 310
 #define TEGRA124_CLK_SOR0_LVDS 311
 #define TEGRA124_CLK_XUSB_SS_DIV2 312
-#define TEGRA124_CLK_CLK_MAX 313
+
+#define TEGRA124_CLK_PLL_M_UD 313
+#define TEGRA124_CLK_PLL_C_UD 314
+
+#define TEGRA124_CLK_CLK_MAX 315
 
 #endif	/* _DT_BINDINGS_CLOCK_TEGRA124_CAR_H */
-- 
1.8.1.5
