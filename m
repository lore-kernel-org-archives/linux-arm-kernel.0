From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 28 Nov 2012 19:59:47 +0530
Subject: [PATCH 1/3] ARM: dts: Add device tree node for G2D controller on
 Exynos5
Message-ID: <1354112989-3161-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 581e57a..6d50c15 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -613,4 +613,10 @@
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
 	};
+
+	g2d: g2d {
+		compatible = "samsung,exynos-g2d-41";
+		reg = <0x10850000 0x1000>;
+		interrupts = <0 91 0>;
+	};
 };
-- 
1.7.1
