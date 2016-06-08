From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:39 +0900
Subject: [PATCH 09/30] ARM: dts: r8a7794: Remove nonexistent thermal sensor
 clock
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <79c530ed4dd374e51f3c8ff75134a1da201952b7.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to the latest information, there is no thermal IP block
present on the r8a7794 SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7794-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 4d3ecd626c1f..a3491ba2f6ec 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -67,7 +67,6 @@
 #define R8A7794_CLK_IRQC		7
 
 /* MSTP5 */
-#define R8A7794_CLK_THERMAL		22
 #define R8A7794_CLK_PWM			23
 
 /* MSTP7 */
-- 
2.1.4
