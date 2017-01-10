From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 Jan 2017 10:27:45 -0300
Subject: [PATCH 2/3] arm64: dts: Add missing unit name to Exynos5433 SoC node
In-Reply-To: <1484054866-3988-1-git-send-email-javier@osg.samsung.com>
References: <1484054866-3988-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1484054866-3988-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning about a mismatch
between a device node reg property and its unit name:

Node /soc has a reg or ranges property, but no unit name

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 68f764e5851c..3695ddaf2e04 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -241,7 +241,7 @@
 		mask = <0x1>;
 	};
 
-	soc: soc {
+	soc: soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4
