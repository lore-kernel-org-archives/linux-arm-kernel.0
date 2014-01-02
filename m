From: tobetter@gmail.com (Dongjin Kim)
Date: Fri,  3 Jan 2014 01:21:46 +0900
Subject: [PATCH] ARM: dts: add clock provider for mshc in Exynos4412
Message-ID: <1388679706-29265-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock lookup information for mshc in Exynos4412.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e743e67..67bef99 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -67,5 +67,7 @@
 		interrupts = <0 77 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 301>, <&clock 149>;
+		clock-names = "biu", "ciu";
 	};
 };
-- 
1.8.1.2
