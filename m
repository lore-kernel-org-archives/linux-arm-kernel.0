From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Mon, 26 Nov 2018 02:55:49 +0900
Subject: [PATCH] clk: rockchip: add clock ID of ACODEC for rk3328
Message-ID: <20181125175549.30535-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock ID of audio CODEC (ACODEC) for rk3328.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 include/dt-bindings/clock/rk3328-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
index 9d5f799469ee..bcaa4559ab1b 100644
--- a/include/dt-bindings/clock/rk3328-cru.h
+++ b/include/dt-bindings/clock/rk3328-cru.h
@@ -172,6 +172,7 @@
 #define PCLK_HDCP		232
 #define PCLK_DCF		233
 #define PCLK_SARADC		234
+#define PCLK_ACODECPHY		235
 
 /* hclk gates */
 #define HCLK_PERI		308
-- 
2.19.1
