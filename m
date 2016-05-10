From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:13 +0200
Subject: [PATCH v3 10/27] ARM: dts: exynos: Use lowercase for Exynos5410 CPU
 node labels
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-11-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency lowercase node labels are used.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 233149abfb62..58d3844ef923 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -35,28 +35,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
 			clock-frequency = <1600000000>;
 		};
 
-		CPU1: cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
 			clock-frequency = <1600000000>;
 		};
 
-		CPU2: cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
 			clock-frequency = <1600000000>;
 		};
 
-		CPU3: cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
-- 
2.5.0
