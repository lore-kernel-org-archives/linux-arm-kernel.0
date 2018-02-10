From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:38:03 +0100
Subject: [PATCH 3/6] ARM: dts: tegra: apalis-tk1: add missing as3722 gpio0
 configuration
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
Message-ID: <20180210013806.28496-4-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As the AS3722 GPIO0 is also a not connected on our Apalis TK1 module
explicitly configure it to high-impedance as well.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 7fbaaf221029..44c31176ce90 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1620,9 +1620,9 @@
 					bias-pull-up;
 				};
 
-				gpio1_3_4_5_6 {
-					pins = "gpio1", "gpio3", "gpio4",
-					       "gpio5", "gpio6";
+				gpio0_1_3_4_5_6 {
+					pins = "gpio0", "gpio1", "gpio3",
+					       "gpio4", "gpio5", "gpio6";
 					bias-high-impedance;
 				};
 			};
-- 
2.14.3
