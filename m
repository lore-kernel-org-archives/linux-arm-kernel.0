From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 20:55:28 +0100
Subject: [PATCH 1/3] clk: rockchip: add id for watchdog pclk on rk3288
In-Reply-To: <1736604.toH3biuFW2@phil>
References: <1736604.toH3biuFW2@phil>
Message-ID: <3744380.nyzH2eD44r@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new id for the pclk supplying the watchdog on rk3288 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 1c34c24..ba0d724 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -157,6 +157,7 @@
 #define PCLK_PUBL0		365
 #define PCLK_DDRUPCTL1		366
 #define PCLK_PUBL1		367
+#define PCLK_WDT		368
 
 /* hclk gates */
 #define HCLK_GPS		448
-- 
2.1.1
