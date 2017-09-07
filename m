From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 07 Sep 2017 18:39:01 +0900
Subject: [PATCH v2 1/3] [media] exynos-gsc: Add compatible for Exynos 5250
 and 5420 specific version
In-Reply-To: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170907093912epcas2p3696ae1d6750c796dc2207747f3421d3c@epcas2p3.samsung.com>
Message-ID: <1504777143-29834-2-git-send-email-hoegeun.kwon@samsung.com>
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
