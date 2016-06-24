From: raashidmuhammed@zilogic.com (Raashid Muhammed)
Date: Fri, 24 Jun 2016 19:01:08 +0530
Subject: [PATCH 1/2] ARM: dts: at91: Add pinctrl information to ethernet node.
Message-ID: <1466775069-606-1-git-send-email-raashidmuhammed@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinctrl information to ethernet node.

Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
---
 arch/arm/boot/dts/at91-sam9_l9260.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
index 349a461..be409f2 100644
--- a/arch/arm/boot/dts/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -49,6 +49,7 @@
 			};
 
 			macb0: ethernet at fffc4000 {
+				pinctrl-0 = <&pinctrl_macb_rmii &pinctrl_macb_rmii_mii_alt>;
 				phy-mode = "mii";
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.1.4
