From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jan 2015 23:39:07 +0800
Subject: [PATCH v9 5/5] ARM: sunxi: dts: axp209: Use clock-frequency for DC-DC
 work frequency
In-Reply-To: <1421941147-9682-1-git-send-email-wens@csie.org>
References: <1421941147-9682-1-git-send-email-wens@csie.org>
Message-ID: <1421941147-9682-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the axp209 dtsi to use new standard bindings for DCDC regulator
work frequency.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp209.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index c20cf537f5a5..ee9487583d31 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -60,7 +60,7 @@
 
 	regulators {
 		/* Default work frequency for buck regulators */
-		x-powers,dcdc-freq = <1500>;
+		clock-frequency = <1500000>;
 
 		reg_dcdc2: dcdc2 {
 			regulator-name = "dcdc2";
-- 
2.1.4
