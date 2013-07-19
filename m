From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 14:58:42 +0100
Subject: [PATCH 11/22] ARM: ux500: Remove '0x's from Exynos5440 DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374242333-6852-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/exynos5440.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index ff7f5d8..0cedba4 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -20,7 +20,7 @@
 		spi0 = &spi_0;
 	};
 
-	clock: clock-controller at 0x160000 {
+	clock: clock-controller at 160000 {
 		compatible = "samsung,exynos5440-clock";
 		reg = <0x160000 0x1000>;
 		#clock-cells = <1>;
-- 
1.8.1.2
