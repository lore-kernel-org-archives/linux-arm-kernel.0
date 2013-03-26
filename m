From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Mar 2013 10:13:15 +0100
Subject: [PATCH 08/10] ARM: sunxi: dt: Update interrupt controller compatible
 string
In-Reply-To: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1364289198-11589-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index be71782..805d704 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -121,7 +121,7 @@
 		ranges;
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sunxi-ic";
+			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 7a81aaf..760222c 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -122,7 +122,7 @@
 		ranges;
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sunxi-ic";
+			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
1.7.10.4
