From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Oct 2013 09:30:05 +0900
Subject: [PATCH 1/3] ARM: dts: exynos4212: Add PMU dt data for pmu-irq
In-Reply-To: <1381365007-1782-1-git-send-email-cw00.choi@samsung.com>
References: <1381365007-1782-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1381365007-1782-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 6f34d7f..3081bae 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -56,4 +56,10 @@
 					<0x5 0 &gic 1 12 0>;
 		};
 	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>, <3 2>;
+	};
 };
-- 
1.8.0
