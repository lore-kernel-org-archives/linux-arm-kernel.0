From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:04:58 +0100
Subject: [PATCH 08/68] ARM: dts: r8a7794: use fallback usbhs compatibility
 string
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <1472ffa81a9089af6250e299068f9a877369333f.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7794 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6c78f1fae90f..f8cd3a0beebf 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -724,7 +724,7 @@
 	};
 
 	hsusb: usb at e6590000 {
-		compatible = "renesas,usbhs-r8a7794";
+		compatible = "renesas,usbhs-r8a7794", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
-- 
2.7.0.rc3.207.g0ac5344
