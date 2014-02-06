From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:47:40 +0900
Subject: [PATCH 2/2] serial: sh-sci: Fix compatible string in DT bindings
 example
In-Reply-To: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
References: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1391669260-23970-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Remove the -generic suffix from the compatible string in the serial port
DT bindings example.

Cc: devicetree at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index f372cf2..53e6c17 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -37,7 +37,7 @@ Example:
 	};
 
 	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.2
