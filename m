From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 17:18:44 +0530
Subject: [PATCH 4/5] ARM: dts: enable fimd for exynos5420 based peach-pit board
In-Reply-To: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397994525-18537-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable fimd for peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 5b70522..d6eaa1f 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -248,4 +248,9 @@
 		ddc = <&i2c_2>;
 		status = "okay";
 	};
+
+	fimd at 14400000 {
+		status = "okay";
+		samsung,invert-vclk;
+	};
 };
-- 
1.7.9.5
