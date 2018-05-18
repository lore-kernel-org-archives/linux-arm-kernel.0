From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:26 +0530
Subject: [PATCH v2 16/26] dt-bindings: clock: sun50i-a64-ccu: Add
 PLL_VIDEO[0-1] macros
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-17-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has two clock parents PLL_VIDEO0 and PLL_VIDEO1.

Include these macros on dt-bindings so-that the same can be
used while defining CCU clock phadles.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index d66432c6e675..d1d7d5b7d06a 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -43,7 +43,9 @@
 #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
+#define CLK_PLL_VIDEO0		7
 #define CLK_PLL_PERIPH0		11
+#define CLK_PLL_VIDEO1		15
 
 #define CLK_BUS_MIPI_DSI	28
 #define CLK_BUS_CE		29
-- 
2.14.3
