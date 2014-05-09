From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 09 May 2014 15:39:43 +0530
Subject: [PATCH v3 1/4] ARM: dts: enable fimd for exynos5250 based snow board
In-Reply-To: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399630186-22610-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable fimd node for snow board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1ce1088..796954c 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -206,4 +206,10 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	fimd at 14400000 {
+		status = "okay";
+		samsung,invert-vclk;
+	};
+
 };
-- 
1.7.9.5
