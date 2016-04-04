From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:19 +0900
Subject: [PATCH 47/47] ARM: dts: r8a7791: Use USB3.0 fallback compatibility
 string
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <64abfd0a89ae1c7e0edcc6744198842e706c0b52.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 5f89b5863d94..4682701fbbed 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1578,7 +1578,7 @@
 	};
 
 	xhci: usb at ee000000 {
-		compatible = "renesas,xhci-r8a7791";
+		compatible = "renesas,xhci-r8a7791", "renesas,rcar-gen2-xhci";
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
-- 
2.1.4
