From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 08 Apr 2016 14:00:43 +0900
Subject: [PATCH 4/7] dt-bindings: clock: Add the clock id for ACLK clock of
 Exynos542x SoC
In-Reply-To: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460091646-28701-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clock id for ACLK clock of Exynos542x SoC. ACLK clock mean
the source clock of AMBA AXI bus. This clock id should be used for Bus
frequency scaling.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 7699ee9c16c0..17ab8394bec7 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -217,8 +217,30 @@
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
+#define CLK_DOUT_ACLK400_WCORE	769
+#define CLK_DOUT_ACLK400_ISP	770
+#define CLK_DOUT_ACLK400_MSCL	771
+#define CLK_DOUT_ACLK200	772
+#define CLK_DOUT_ACLK200_FSYS2	773
+#define CLK_DOUT_ACLK100_NOC	774
+#define CLK_DOUT_PCLK200_FSYS	775
+#define CLK_DOUT_ACLK200_FSYS	776
+#define CLK_DOUT_ACLK333_432_GSCL	777
+#define CLK_DOUT_ACLK333_432_ISP	778
+#define CLK_DOUT_ACLK66		779
+#define CLK_DOUT_ACLK333_432_ISP0	780
+#define CLK_DOUT_ACLK266	781
+#define CLK_DOUT_ACLK166	782
+#define CLK_DOUT_ACLK333	783
+#define CLK_DOUT_ACLK333_G2D	784
+#define CLK_DOUT_ACLK266_G2D	785
+#define CLK_DOUT_ACLK_G3D	786
+#define CLK_DOUT_ACLK300_JPEG	787
+#define CLK_DOUT_ACLK300_DISP1	788
+#define CLK_DOUT_ACLK300_GSCL	789
+#define CLK_DOUT_ACLK400_DISP1	790
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		769
+#define CLK_NR_CLKS		791
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
1.9.1
