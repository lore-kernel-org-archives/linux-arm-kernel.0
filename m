From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 12 Dec 2016 14:05:38 +0100
Subject: [PATCH v6 1/5] ARM: dts: da850: rename the display node label
In-Reply-To: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481547942-24775-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tilcdc node name is 'display' as per the ePAPR 1.1 recommendation.
The label is also 'display', but change it to 'lcdc' to make it clear
what the underlying hardware is.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index ffc6e1a..3f51e59 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -448,7 +448,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		display: display at 213000 {
+		lcdc: display at 213000 {
 			compatible = "ti,da850-tilcdc";
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
-- 
2.9.3
