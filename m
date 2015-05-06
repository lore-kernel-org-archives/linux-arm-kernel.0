From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed,  6 May 2015 15:13:59 +0200
Subject: [PATCH 1/2] ARM: mvebu: add alias for mdio on Armada 38x
In-Reply-To: <1430918040-17307-1-git-send-email-kaloz@openwrt.org>
References: <1430918040-17307-1-git-send-email-kaloz@openwrt.org>
Message-ID: <1430918040-17307-2-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to reference it later.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index ed2dd8b..839e5bf 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -495,7 +495,7 @@
 				status = "disabled";
 			};
 
-			mdio at 72004 {
+			mdio: mdio at 72004 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
-- 
2.1.0
