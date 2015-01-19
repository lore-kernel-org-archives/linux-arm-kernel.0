From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Mon, 19 Jan 2015 22:35:22 +0300
Subject: [PATCH] ARM: dts: sunxi: Add missing mdio label
Message-ID: <1421696122-5389-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add missing mdio label for sun[457]i.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ca79172..6a57f5b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -464,7 +464,7 @@
 			status = "disabled";
 		};
 
-		mdio at 01c0b080 {
+		mdio: mdio at 01c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 76c20c5..74b201a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -367,7 +367,7 @@
 			status = "disabled";
 		};
 
-		mdio at 01c0b080 {
+		mdio: mdio at 01c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 49ae6e6..e10c2b8 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -588,7 +588,7 @@
 			status = "disabled";
 		};
 
-		mdio at 01c0b080 {
+		mdio: mdio at 01c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
-- 
2.0.5
