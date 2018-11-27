From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:09 +0100
Subject: [PATCH 08/77] ARM: dts: sun5i: Remove redundant interrupt-controller
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <56b1dd7aa2ad7cb02edae229968af30871760899.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt-parent property is set in sun5i.dtsi, so there's no need to
repeat it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 --
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index a2d0ceacf00e..195a6a1d2c49 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -47,8 +47,6 @@
 #include <dt-bindings/dma/sun4i-a10.h>
 
 / {
-	interrupt-parent = <&intc>;
-
 	aliases {
 		ethernet0 = &emac;
 	};
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ee99f6f23f17..ae04955fd9a3 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -47,8 +47,6 @@
 #include <dt-bindings/thermal/thermal.h>
 
 / {
-	interrupt-parent = <&intc>;
-
 	thermal-zones {
 		cpu_thermal {
 			/* milliseconds */
-- 
git-series 0.9.1
