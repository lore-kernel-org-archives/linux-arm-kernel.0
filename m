From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 10:50:50 +0900
Subject: [PATCH 3/3] clocksource: sh_mtu2: Drop incorrect SoC family name
In-Reply-To: <cover.1414629281.git.horms+renesas@verge.net.au>
References: <cover.1414629281.git.horms+renesas@verge.net.au>
Message-ID: <d5153cd734dd6c1243bb3dc98065be99b10d049f.1414629281.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The MTU2 hardware block is found in many Renesas SH and ARM SoCs, but
not in R-Car.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
index d9a8d5a..ba0a34d 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
@@ -1,4 +1,4 @@
-* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
+* Renesas Multi-Function Timer Pulse Unit 2 (MTU2)
 
 The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
 clock inputs and programmable compare match.
-- 
2.1.1
