From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Sun, 18 Nov 2018 13:18:02 +0900
Subject: [PATCH] clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
Message-ID: <20181118041802.11660-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes mistakes in HCLK_I2S1_8CH for running I2S1
successfully.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 include/dt-bindings/clock/rk3328-cru.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
index a82a0109faff..bcaa4559ab1b 100644
--- a/include/dt-bindings/clock/rk3328-cru.h
+++ b/include/dt-bindings/clock/rk3328-cru.h
@@ -172,13 +172,14 @@
 #define PCLK_HDCP		232
 #define PCLK_DCF		233
 #define PCLK_SARADC		234
+#define PCLK_ACODECPHY		235
 
 /* hclk gates */
 #define HCLK_PERI		308
 #define HCLK_TSP		309
 #define HCLK_GMAC		310
 #define HCLK_I2S0_8CH		311
-#define HCLK_I2S1_8CH		313
+#define HCLK_I2S1_8CH		312
 #define HCLK_I2S2_2CH		313
 #define HCLK_SPDIF_8CH		314
 #define HCLK_VOP		315
-- 
2.19.1
