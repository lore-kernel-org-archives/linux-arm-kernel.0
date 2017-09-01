From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 01 Sep 2017 10:47:55 +0900
Subject: [PATCH 2/3] arm64: dts: exynos: Add the hardware rotation limits
 for gsc
In-Reply-To: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170901014758epcas2p201036a38e7d079e10732d1c43c6248d7@epcas2p2.samsung.com>
Message-ID: <1504230476-1878-3-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gscaler has maximum size of input or output rotation. Add the
hardware limits property for the gscaler rotation in the exynos5433
dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 7fe994b..57c9997 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -891,6 +891,8 @@
 				 <&cmu_gscl CLK_ACLK_GSCL0>,
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
+			rot-max-hsize = <2047>;
+			rot-max-vsize = <2047>;
 			iommus = <&sysmmu_gscl0>;
 		};
 
@@ -904,6 +906,8 @@
 				 <&cmu_gscl CLK_ACLK_GSCL1>,
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
+			rot-max-hsize = <2047>;
+			rot-max-vsize = <2047>;
 			iommus = <&sysmmu_gscl1>;
 		};
 
@@ -917,6 +921,8 @@
 				 <&cmu_gscl CLK_ACLK_GSCL2>,
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
+			rot-max-hsize = <2047>;
+			rot-max-vsize = <2047>;
 			iommus = <&sysmmu_gscl2>;
 		};
 
-- 
1.9.1
