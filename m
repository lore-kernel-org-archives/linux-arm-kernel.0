From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jul 2013 11:52:27 +0100
Subject: [PATCH 08/22] ARM: dts: Remove '0x's from Exynos4x12 DTSI file
In-Reply-To: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374490361-25769-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 01da194..3aa2f06 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -28,7 +28,7 @@
 		pinctrl3 = &pinctrl_3;
 	};
 
-	clock: clock-controller at 0x10030000 {
+	clock: clock-controller at 10030000 {
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
-- 
1.8.1.2
