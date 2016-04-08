From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 08 Apr 2016 14:00:42 +0900
Subject: [PATCH 3/7] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
In-Reply-To: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the NoCP (Network on Chip Probe) Device Tree node
to measure the bandwidth of memory and g3d in Exynos542x SoC.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7b99cb58d82d..d80f3b66f017 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -294,6 +294,42 @@
 		};
 	};
 
+	nocp_mem0_0: nocp_mem0_0 at 10CA1000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_1: nocp_mem0_1 at 10CA1400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1400 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_2: nocp_mem0_2 at 10CA1800 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1800 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_3: nocp_mem0_3 at 10CA1C00 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1C00 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_0: nocp_g3d_0 at 11A51000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_1: nocp_g3d_1 at 11A51400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51400 0x200>;
+		status = "disabled";
+	};
+
 	gsc_pd: power-domain at 10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
-- 
1.9.1
