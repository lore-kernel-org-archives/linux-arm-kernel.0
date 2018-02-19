From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 19 Feb 2018 13:47:35 +0100
Subject: [PATCH v4 12/13] ARM: dtsi: axp81x: remove IP name from DT node name
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <e72308b0ce1f2c7efa25a5e879159376a41bd453.1519044068.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT node should be named after its functionality and not after the
IP it's defining.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp81x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 1b05c7f..043c717 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -53,7 +53,7 @@
 		#io-channel-cells = <1>;
 	};
 
-	axp_gpio: axp-gpio {
+	axp_gpio: gpio {
 		compatible = "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
-- 
git-series 0.9.1
