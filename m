From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 08 May 2014 11:49:54 +0530
Subject: [PATCH v2 4/5] ARM: dts: enable fimd for exynos5420 based peach-pit
 board
In-Reply-To: <1399529995-8656-1-git-send-email-rahul.sharma@samsung.com>
References: <1399529995-8656-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399529995-8656-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable fimd for peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index fae33dd..f75da5b 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -145,3 +145,8 @@
 &watchdog {
 	timeout-sec = <32>;
 };
+
+&fimd {
+	status = "okay";
+	samsung,invert-vclk;
+};
-- 
1.7.9.5
