From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Sep 2015 11:05:32 +0800
Subject: [PATCH 3/3] ARM: dts: sun6i: hummingbird: Rename AXP221 DC1SW and
 DC5LDO supply names
In-Reply-To: <1442372732-27434-1-git-send-email-wens@csie.org>
References: <1442372732-27434-1-git-send-email-wens@csie.org>
Message-ID: <1442372732-27434-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"dcdc1-supply" and "dcdc5-supply" are renamed to "dc1sw-supply" and
"dc5ldo-supply" respectively. Update the dts to reflect the new supply
names for the regulators.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 06d9391ca30e..144f563a3d6d 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -178,8 +178,8 @@
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		dcdc1-supply = <&vcc_3v0>;
-		dcdc5-supply = <&vcc_dram>;
+		dc1sw-supply = <&vcc_3v0>;
+		dc5ldo-supply = <&vcc_dram>;
 
 		regulators {
 			x-powers,dcdc-freq = <3000>;
-- 
2.5.1
