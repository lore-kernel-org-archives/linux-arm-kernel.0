From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 04 Nov 2013 10:56:00 +0900
Subject: [PATCHv3 2/3] ARM: dts: exynos4212: Add missing clock for multi core
 timer
In-Reply-To: <1383530161-24080-1-git-send-email-cw00.choi@samsung.com>
References: <1383530161-24080-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1383530161-24080-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3081bae..d7a3fbc 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -43,6 +43,8 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>;
+		clocks = <&clock 3>, <&clock 344>;
+		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
 			#interrupt-cells = <2>;
-- 
1.8.0
