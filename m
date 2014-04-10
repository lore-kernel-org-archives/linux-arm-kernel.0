From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:02 +0900
Subject: [PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent
 connected with GIC
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add interrupt-parent node to connected with GIC.
All interrupt-related dt nodes need default interrupt-parent node.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index fe8960e..13efdbed 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -21,6 +21,7 @@
 
 / {
 	compatible = "samsung,exynos3250";
+	interrupt-parent = <&gic>;
 
 	chipid at 10000000 {
 		compatible = "samsung,exynos4210-chipid";
-- 
1.8.0
