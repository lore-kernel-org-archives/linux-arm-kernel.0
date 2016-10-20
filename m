From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 10:12:45 +0200
Subject: [PATCH 4/8] ARM: gr8: Fix typo in the i2s mclk pin group
In-Reply-To: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f1c79380c34fcc2a1c1ff75ca91177de3b7380a9.1476951078.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a dumb copy and paste mistake here, fix it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/ntc-gr8.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
index d7cf6be2549c..74aff795e723 100644
--- a/arch/arm/boot/dts/ntc-gr8.dtsi
+++ b/arch/arm/boot/dts/ntc-gr8.dtsi
@@ -792,7 +792,7 @@
 			};
 
 			i2s0_mclk_pins_a: i2s0-mclk at 0 {
-				allwinner,pins = "PB6", "PB7", "PB8", "PB9";
+				allwinner,pins = "PB5";
 				allwinner,function = "i2s0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
git-series 0.8.10
