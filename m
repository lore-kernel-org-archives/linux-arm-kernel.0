From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:07 +0200
Subject: [PATCH 40/42] dt-bindings: clk: r7s72100: Add missing I and G clocks
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <44842cc8a89aa7742bc47737aa75da5910aa5f33.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the missing definitions for the I (CPU) and G (Image Processing)
clocks, so these clocks can be referred to from device nodes in DT.

Note that these clocks are already fully supported otherwise (DT
bindings, Linux driver, r7s72100.dtsi), they were just omitted from the
header file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r7s72100-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 7dd8bc0c3cd0..0dcb3e87d44c 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -11,6 +11,8 @@
 #define __DT_BINDINGS_CLOCK_R7S72100_H__
 
 #define R7S72100_CLK_PLL	0
+#define R7S72100_CLK_I		1
+#define R7S72100_CLK_G		2
 
 /* MSTP2 */
 #define R7S72100_CLK_CORESIGHT	0
-- 
2.11.0
