From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 21 Oct 2015 10:33:23 +0900
Subject: [PATCH] MAINTAINERS: ARM: EXYNOS: Add documentation and dt-bindings
Message-ID: <1445391203-3819-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the Samsung Exynos maintainer entry to match SoC documentation
and SoC dt-bindings directories. Without that some files, like
bindings/arm/samsung/pmu.txt, are not matched by existing patterns.

This also may serve as a hint where new documentation and bindings (not
matching specific subsystem) should be put.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b556aad90930..cad7b6b628b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1459,6 +1459,8 @@ F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
 F:	drivers/spi/spi-s3c*
 F:	sound/soc/samsung/*
+F:	Documentation/arm/Samsung/
+F:	Documentation/devicetree/bindings/arm/samsung/
 N:	exynos
 
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
-- 
1.9.1
