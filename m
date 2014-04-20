From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 17:18:42 +0530
Subject: [PATCH 2/5] ARM: dts: enable fimd for exynos5250 based snow board
In-Reply-To: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397994525-18537-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable fimd node for snow board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 586cd38..09f363d 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -344,6 +344,11 @@
 		};
 	};
 
+	fimd at 14400000 {
+		status = "okay";
+		samsung,invert-vclk;
+	};
+
 	hdmi {
 		hdmi-en-supply = <&tps65090_fet7>;
 		vdd-supply = <&ldo8_reg>;
-- 
1.7.9.5
