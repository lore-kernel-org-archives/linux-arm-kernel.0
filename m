From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Nov 2014 16:13:02 -0800
Subject: [PATCH 1/2] clk: rockchip: add binding ID for DMC (memory controller)
 clocks on rk3288
Message-ID: <1416960783-25119-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeff Chen <cym@rock-chips.com>

The DMC clocks need to be turned off at runtime, so we should have IDs
so we can export them.

Signed-off-by: Jeff Chen <cym@rock-chips.com>
[dianders: split into two patches; adjusted commit msg]
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 include/dt-bindings/clock/rk3288-cru.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 100a08c..8e19ed5 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -141,6 +141,10 @@
 #define PCLK_VIO2_H2P		361
 #define PCLK_CPU		362
 #define PCLK_PERI		363
+#define PCLK_DDRUPCTL0		364
+#define PCLK_PUBL0		365
+#define PCLK_DDRUPCTL1		366
+#define PCLK_PUBL1		367
 
 /* hclk gates */
 #define HCLK_GPS		448
-- 
2.1.0.rc2.206.gedb03e5
