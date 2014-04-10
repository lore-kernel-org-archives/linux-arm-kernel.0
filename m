From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 10 Apr 2014 10:03:40 +0200
Subject: [PATCH BUGFIX] arm: dts: imx53: fix apparent copy/paste error
Message-ID: <1397117020-8900-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'remote-endpoint' property should point back to ipu_di1_lvds1
rather than ipu_di0_lvds0.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index f0962e5..33a4e5b 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -431,7 +431,7 @@
 
 					port {
 						lvds1_in: endpoint {
-							remote-endpoint = <&ipu_di0_lvds0>;
+							remote-endpoint = <&ipu_di1_lvds1>;
 						};
 					};
 				};
-- 
1.7.10.4
