From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 11:26:15 +0200
Subject: [PATCH 3/5] arm: dts: sun8i: a83t: Add MMC1 pins
In-Reply-To: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
Message-ID: <20170825092617.32533-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pinctrl definitions for the A83t MMC1 controller.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 8df34d8ac51d..91dee798f3ca 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -342,6 +342,14 @@
 				bias-pull-up;
 			};
 
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2",
+				       "PG3", "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_8bit_emmc_pins: mmc2-8bit-emmc-pins {
 				pins = "PC5", "PC6", "PC8", "PC9",
 				       "PC10", "PC11", "PC12", "PC13",
-- 
2.13.5
