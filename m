From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Tue, 26 Mar 2013 10:35:36 +0530
Subject: [PATCH] ARM : dts : Added clock definition for MFC as per Common clock
 framework
Message-ID: <1364274336-31275-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Kumar <prasanna.ps@samsung.com>

According to Common clock framework, clock definition is added
for exynos5250

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 24c52e6..652a63e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -128,6 +128,8 @@
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
 		samsung,power-domain = <&pd_mfc>;
+		clocks = <&clock 266>;
+		clock-names = "mfc";
 	};
 
 	rtc {
-- 
1.7.5.4
