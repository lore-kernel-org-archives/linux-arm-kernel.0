From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 13 Mar 2014 08:57:02 +0530
Subject: [PATCH 1/1] clk: exynos-5420: Fix VPLL lock offset
Message-ID: <1394681222-27882-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set it as per the user manual.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5420.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 60b26819bed5..7fd6bea467fd 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -33,7 +33,7 @@
 #define RPLL_LOCK		0x10050
 #define IPLL_LOCK		0x10060
 #define SPLL_LOCK		0x10070
-#define VPLL_LOCK		0x10070
+#define VPLL_LOCK		0x10080
 #define MPLL_LOCK		0x10090
 #define CPLL_CON0		0x10120
 #define DPLL_CON0		0x10128
-- 
1.7.9.5
