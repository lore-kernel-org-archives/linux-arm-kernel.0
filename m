From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:41 +0200
Subject: [PATCH 46/58] arm64: dts: renesas: r8a77965: Fix HS-USB compatible
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <99584d93e301d820d817bba2eb77b9152e13009c.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Should be "renesas,usbhs-r8a77965", not "renesas,usbhs-r8a7796".

Fixes: a06e8af801760a98 ("arm64: dts: renesas: r8a77965: add HS-USB node")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 7f477a15fa59..108f53cfef5c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -589,7 +589,7 @@
 		};
 
 		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7796",
+			compatible = "renesas,usbhs-r8a77965",
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
