From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Tue, 10 Jan 2017 19:59:17 +0800
Subject: [PATCH 1/4] clk: rockchip: add rk3288 isp_in clock ids
Message-ID: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock-ids for the isp block of the rk3288.


Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 9a586e2..08de7de 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -168,6 +168,7 @@
 #define PCLK_WDT		368
 #define PCLK_EFUSE256		369
 #define PCLK_EFUSE1024		370
+#define PCLK_ISP_IN		371
 
 /* hclk gates */
 #define HCLK_GPS		448
-- 
2.7.4
