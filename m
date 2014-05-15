From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 20:34:22 +0530
Subject: [PATCH v5 2/4] ARM: dts: change to correct compatible string for
 exynos5420 hdmi
In-Reply-To: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
References: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400166264-3428-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Replace compatible string for HDMI node in Exynos5420. Since
latest restructring in Drm hdmi driver, it is agreed to use
a seperate compatible string for Exynos5420 HDMI IP siince it
uses APB mapped Phy.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
Acked-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index a802f74..016992c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -640,7 +640,7 @@
 	};
 
 	hdmi: hdmi at 14530000 {
-		compatible = "samsung,exynos4212-hdmi";
+		compatible = "samsung,exynos5420-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
 		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
-- 
1.7.9.5
