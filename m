From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:47:36 +0200
Subject: [PATCHv3 09/10] ARM: sun6i: Add UART0 muxing options
In-Reply-To: <1375609657-15434-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375609657-15434-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375609657-15434-10-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 2bf6404..b206326 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -76,6 +76,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PH20", "PH21";
+				allwinner,function = "uart0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.3.4
