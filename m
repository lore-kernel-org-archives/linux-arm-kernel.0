From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:29 +0200
Subject: [PATCH 2/6] clk: stm32mp1: remove unused dfsdm_src[] const
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1522996773-24129-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch remove unused constant.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 62f172c..9a67b1c 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -224,10 +224,6 @@
 	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
 };
 
-static const char * const dfsdm_src[] = {
-	"pclk2", "ck_mcu"
-};
-
 static const char * const fdcan_src[] = {
 	"ck_hse", "pll3_q", "pll4_q"
 };
-- 
1.9.1
