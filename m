From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 14:30:28 +0100
Subject: [PATCH 05/10] ARM: sunxi: dt: Update timer compatible string
In-Reply-To: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1364218233-29636-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5c0920b..be71782 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -158,7 +158,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sunxi-timer";
+			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index fdc5346..7a81aaf 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -152,7 +152,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sunxi-timer";
+			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
-- 
1.7.10.4
