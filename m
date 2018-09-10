From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 10 Sep 2018 20:39:10 +0200
Subject: [PATCH] arm64: dts: meson-axg: use the proper compatible for ethmac
Message-ID: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct compatible for the AXG ethernet mac node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 32f6dca..75f4ca7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -525,7 +525,7 @@
 		};
 
 		ethmac: ethernet at ff3f0000 {
-			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 				0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
-- 
2.7.4
