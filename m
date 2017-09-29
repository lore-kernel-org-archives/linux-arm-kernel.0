From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:49 +0200
Subject: [PATCH 2/8] dt-bindings: display: renesas: dw-hdmi: Drop bogus node
 name suffix
In-Reply-To: <cover.1506676368.git.horms+renesas@verge.net.au>
References: <cover.1506676368.git.horms+renesas@verge.net.au>
Message-ID: <8ac491a5d0934bf1a77db155d759c682ab790c45.1506676368.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Node names should not use numerical suffixes if the nodes can be
distinguished by unit-address.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
index b1a8929c2536..3a72a103a18a 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
@@ -37,7 +37,7 @@ Optional properties:
 
 Example:
 
-	hdmi0: hdmi0 at fead0000 {
+	hdmi0: hdmi at fead0000 {
 		compatible = "renesas,r8a7795-dw-hdmi";
 		reg = <0 0xfead0000 0 0x10000>;
 		interrupts = <0 389 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
