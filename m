From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sat, 26 Dec 2015 00:32:25 +0100
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
Message-ID: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for omap3 with documentation is there since v4.4-rc1.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
 arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 4f6b2d5..c3f488f 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -54,6 +54,11 @@
 				#size-cells = <0>;
 			};
 		};
+
+		bandgap {
+			reg = <0x48002524 0x4>;
+			compatible = "ti,omap34xx-bandgap";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 86253de..00f98c1 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -86,6 +86,11 @@
 				#size-cells = <0>;
 			};
 		};
+
+		bandgap {
+			reg = <0x48002524 0x4>;
+			compatible = "ti,omap36xx-bandgap";
+		};
 	};
 };
 
-- 
1.7.9.5
