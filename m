From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 15 Nov 2018 15:50:00 +0100
Subject: [PATCH 02/15] ARM: dts: sun8i-h3: Remove heading 0 in video-codec
 unit address
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181115145013.3378-3-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cosmetic change removes the heading 0 in the video-codec unit
address, as it's done for other nodes.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3ecfabb10151..35d025af7deb 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -156,7 +156,7 @@
 			};
 		};
 
-		video-codec at 01c0e000 {
+		video-codec at 1c0e000 {
 			compatible = "allwinner,sun8i-h3-video-engine";
 			reg = <0x01c0e000 0x1000>;
 			clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>,
-- 
2.19.1
