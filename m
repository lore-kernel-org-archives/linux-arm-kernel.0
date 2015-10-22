From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 22 Oct 2015 10:28:19 +0900
Subject: [PATCH v2] MAINTAINERS: ARM: EXYNOS: Add documentation and dt-bindings
Message-ID: <1445477299-560-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the Samsung Exynos maintainer entry to match SoC documentation
and SoC dt-bindings directories. Without that some files, like
bindings/arm/samsung/pmu.txt, are not matched by existing patterns.

This also may serve as a hint where new documentation and bindings (not
matching specific subsystem) should be put.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Added Javier's reviewed-by
2. Cover also power domain and sram bindings located now in separate
   directory.
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b556aad90930..6339926c77d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1459,6 +1459,10 @@ F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
 F:	drivers/spi/spi-s3c*
 F:	sound/soc/samsung/*
+F:	Documentation/arm/Samsung/
+F:	Documentation/devicetree/bindings/arm/samsung/
+F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
+F:	Documentation/devicetree/bindings/power/pd-samsung.txt
 N:	exynos
 
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
-- 
1.9.1
