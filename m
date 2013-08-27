From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 27 Aug 2013 14:04:56 +0200
Subject: [PATCH] ARM: at91/dt: fix phy address to match the reg register
Message-ID: <1377605096-20903-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix phy0 address to match the reg porperty defined in phy0 node.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3xmb.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index e9521d5..dba739b 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -84,7 +84,7 @@
 
 				#address-cells = <1>;
 				#size-cells = <0>;
-				phy0: ethernet-phy at 0 {
+				phy0: ethernet-phy at 1 {
 					interrupt-parent = <&pioE>;
 					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
 					reg = <1>;
-- 
1.7.9.5
