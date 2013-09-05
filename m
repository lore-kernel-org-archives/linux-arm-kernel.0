From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu,  5 Sep 2013 16:59:53 +0530
Subject: [PATCH v3 2/2] arm: dt: Exynos5420: populate cpu node enteries to 8
 cpus
In-Reply-To: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
References: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1378380593-5305-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 is octacore SoC from samsung.
Hence populate all the cpu node enteries.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/boot/dts/exynos5420.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e97c87b..0bd1a40 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -57,6 +57,34 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 		};
+
+		cpu4: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu5: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu6: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu7: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <1000000000>;
+		};
 	};
 
 	clock: clock-controller at 0x10010000 {
-- 
1.7.9.5
