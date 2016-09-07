From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed,  7 Sep 2016 09:58:55 +0200
Subject: [PATCH v4 2/8] dts: sun8i-h3: clarify uart1 pinmux definition name
In-Reply-To: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473235141-12768-3-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 3779280..45f623b 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -185,7 +185,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>;
+	pinctrl-0 = <&uart1_rts_cts_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index ee10004..933d42c 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -367,7 +367,7 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart1_pins_a: uart1 at 0 {
+			uart1_rts_cts_pins: uart1_rts_cts {
 				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
 				allwinner,function = "uart1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
2.7.4
