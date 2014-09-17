From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 18 Sep 2014 00:12:53 +0200
Subject: [PATCH v3 7/8] clk: rockchip: add binding id for ARMCLK
In-Reply-To: <1410991974-12235-1-git-send-email-heiko@sntech.de>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
Message-ID: <1410991974-12235-8-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3188-cru-common.h | 1 +
 include/dt-bindings/clock/rk3288-cru.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index 750ee60..6a37050 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -20,6 +20,7 @@
 #define PLL_GPLL		4
 #define CORE_PERI		5
 #define CORE_L2C		6
+#define ARMCLK			7
 
 /* sclk gates (special clocks) */
 #define SCLK_UART0		64
diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index ebcb460..8f75bf0 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -19,6 +19,7 @@
 #define PLL_CPLL		3
 #define PLL_GPLL		4
 #define PLL_NPLL		5
+#define ARMCLK			6
 
 /* sclk gates (special clocks) */
 #define SCLK_GPU		64
-- 
2.0.1
