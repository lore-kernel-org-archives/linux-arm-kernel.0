From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 17:41:47 +0900
Subject: [PATCH 1/2] dt-bindings: Add the clock id for CMU_CDREX (DRAM Express
 Controller)
In-Reply-To: <1471855308-12791-1-git-send-email-cw00.choi@samsung.com>
References: <1471855308-12791-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471855308-12791-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the new clock id for CMU_CDRES (DRAM Express Controller)
geneates the clocks for DRAM and NoC (Network on Chip) bus clock.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 17ab8394bec7..6fd21c291416 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -214,6 +214,9 @@
 #define CLK_MOUT_SW_ACLK400     651
 #define CLK_MOUT_USER_ACLK300_GSCL	652
 #define CLK_MOUT_SW_ACLK300_GSCL	653
+#define CLK_MOUT_MCLK_CDREX	654
+#define CLK_MOUT_BPLL		655
+#define CLK_MOUT_MX_MSPLL_CCORE	656
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -239,8 +242,14 @@
 #define CLK_DOUT_ACLK300_DISP1	788
 #define CLK_DOUT_ACLK300_GSCL	789
 #define CLK_DOUT_ACLK400_DISP1	790
+#define CLK_DOUT_PCLK_CDREX	791
+#define CLK_DOUT_SCLK_CDREX	792
+#define CLK_DOUT_ACLK_CDREX1	793
+#define CLK_DOUT_CCLK_DREX0	794
+#define CLK_DOUT_CLK2X_PHY0	795
+#define CLK_DOUT_PCLK_CORE_MEM	796
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		791
+#define CLK_NR_CLKS		797
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
1.9.1
