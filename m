From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Mar 2018 18:27:08 +0100
Subject: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property to
 hdmi device node
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
Message-ID: <20180307172711.15697-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is required for specifying link between the HDMI IP block
and the SoC's audio subsystem.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 56626d1a4235..71d2ede118e3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -700,6 +700,7 @@
 					"sclk_hdmiphy", "mout_hdmi";
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			phy = <&hdmiphy>;
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.14.2
