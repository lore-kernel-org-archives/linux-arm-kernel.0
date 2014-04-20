From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 16:54:00 +0530
Subject: [PATCH 3/7] ARM: dtsi: add access to simple hdmiphy to exynos5250 hdmi
 node
In-Reply-To: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397993044-14564-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add reference to simple phy to hdmi node for exynos5420

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 ++
 1 file changed, 2 insertions(+)
 mode change 100755 => 100644 arch/arm/boot/dts/exynos5250.dtsi

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
old mode 100755
new mode 100644
index bbf2d64..ddd687e
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -690,6 +690,8 @@
 			 <&clock CLK_MOUT_HDMI>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 				"sclk_hdmiphy", "mout_hdmi";
+		phys = <&simple_phys 0>;
+		phy-names = "hdmiphy";
 	};
 
 	mixer {
-- 
1.7.9.5
