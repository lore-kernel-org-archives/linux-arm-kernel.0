From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 14:30:33 +0100
Subject: [PATCH 10/10] ARM: sunxi: dt: Update watchdog compatible string
In-Reply-To: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1364218233-29636-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 805d704..aee190c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -165,7 +165,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sunxi-wdt";
+			compatible = "allwinner,sun4i-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 760222c..72c4948 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -159,7 +159,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sunxi-wdt";
+			compatible = "allwinner,sun4i-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-- 
1.7.10.4
