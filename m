From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 21:32:45 +0900
Subject: [PATCH] ARM: dts: Add more opp levels in exynos5440
Message-ID: <150f01ce6832$1b7db600$52792200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch updates cpu frequency level from 1500 to 800MHZ in steps
of 100MHZ. The corresponding voltage(in uV) is also added.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index e8f5745..80ed5d9 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -79,8 +79,13 @@
 		interrupts = <0 57 0>;
 		operating-points = <
 				/* KHz	  uV */
+				1500000 1100000
+				1400000 1075000
+				1300000 1050000
 				1200000 1025000
+				1100000 1000000
 				1000000 975000
+				900000  950000
 				800000  925000
 		>;
 	};
-- 
1.7.10.4
