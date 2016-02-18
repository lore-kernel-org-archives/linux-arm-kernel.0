From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 18 Feb 2016 14:14:18 +0900
Subject: [PATCH 1/3] thermal: exynos: Document compatible for Exynos5433 TMU
Message-ID: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 488c7455d74c ("thermal: exynos: Add the support for Exynos5433
TMU") added new compatible but forgot to update documentation.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 695150a4136b..34315d7fbfde 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -11,6 +11,7 @@
 	       "samsung,exynos5420-tmu" for TMU channel 0, 1 on Exynos5420
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
+               "samsung,exynos5433-tmu"
 	       "samsung,exynos5440-tmu"
 	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
-- 
2.5.0
