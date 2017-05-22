From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:04 +0200
Subject: [PATCH 3/3] ARM: dts: r7s72100: add USB bit definitions
In-Reply-To: <cover.1495454780.git.horms+renesas@verge.net.au>
References: <cover.1495454780.git.horms+renesas@verge.net.au>
Message-ID: <40c9bbea140e64a4257b794969e759c2c481c399.1495454780.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add the bit locations that correspond to the USB clocks.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r7s72100-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index bc256d31099a..dcd2072151fc 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -34,6 +34,8 @@
 
 /* MSTP7 */
 #define R7S72100_CLK_ETHER	4
+#define R7S72100_CLK_USB0	1
+#define R7S72100_CLK_USB1	0
 
 /* MSTP8 */
 #define R7S72100_CLK_MMCIF	4
-- 
2.1.4
