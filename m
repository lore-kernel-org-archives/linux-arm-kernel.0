From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Dec 2012 10:13:30 +0900
Subject: [PATCH] ARM: dts: cleanup exynos5440.dtsi
Message-ID: <031b01cdd673$90cb7b50$b26271f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


remove duplicated compatible

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 024269d..5406689 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -58,11 +58,6 @@
 		};
 	};
 
-	common {
-		compatible = "samsung,exynos5440";
-
-	};
-
 	serial at B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
-- 
1.7.4.1
