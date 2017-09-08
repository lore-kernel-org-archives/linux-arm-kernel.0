From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 08 Sep 2017 15:02:35 +0900
Subject: [PATCH v3 1/6] [media] exynos-gsc: Add compatible for Exynos 5250
 and 5420 specific version
In-Reply-To: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170908060308epcas1p4cd62b065429a7ab1591593e94853c7b8@epcas1p4.samsung.com>
Message-ID: <1504850560-27950-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos 5250 and 5420 have different hardware rotation limits.
Since we have to distinguish between these two, we add different
compatible(samsung,exynos5250-gsc and samsung,exynos5420-gsc).

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 Documentation/devicetree/bindings/media/exynos5-gsc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/exynos5-gsc.txt b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
index 26ca25b..daa56d5 100644
--- a/Documentation/devicetree/bindings/media/exynos5-gsc.txt
+++ b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
@@ -5,6 +5,7 @@ G-Scaler is used for scaling and color space conversion on EXYNOS5 SoCs.
 Required properties:
 - compatible: should be "samsung,exynos5-gsc" (for Exynos 5250, 5420 and
 	      5422 SoCs) or "samsung,exynos5433-gsc" (Exynos 5433)
+	      or "samsung,exynos5250-gsc" or "samsung,exynos5420-gsc"
 - reg: should contain G-Scaler physical address location and length.
 - interrupts: should contain G-Scaler interrupt number
 
-- 
1.9.1
