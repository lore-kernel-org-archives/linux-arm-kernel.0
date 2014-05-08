From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 08 May 2014 16:07:57 +0530
Subject: [PATCH v2 2/4] ARM: dts: change to correct compatible string for
 exynos5420 hdmi
In-Reply-To: <1399545479-20086-1-git-send-email-rahul.sharma@samsung.com>
References: <1399545479-20086-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399545479-20086-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Replace compatible string for HDMI node in Exynos5420. Since
latest restructring in Drm hdmi driver, it is agreed to use
a seperate compatible string for Exynos5420 HDMI IP siince it
uses APB mapped Phy.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0d1dea8..f1f6a06 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -633,7 +633,7 @@
 	};
 
 	hdmi: hdmi at 14530000 {
-		compatible = "samsung,exynos4212-hdmi";
+		compatible = "samsung,exynos5420-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
 		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
-- 
1.7.9.5
