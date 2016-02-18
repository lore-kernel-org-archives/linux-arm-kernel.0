From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Feb 2016 15:12:59 +0100
Subject: [PATCH v2 12/13] iommu: exynos: add Maintainers entry for Exynos
 SYSMMU driver
In-Reply-To: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1455804780-9616-13-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Marek Szyprowski as maintainer for Exynos IOMMU driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2f753cb357..4afc061e878a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4305,6 +4305,12 @@ L:	dri-devel at lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/exynos/exynos_dp*
 
+EXYNOS SYSMMU (IOMMU) driver
+M:	Marek Szyprowski <m.szyprowski@samsung.com>
+L:	iommu at lists.linux-foundation.org
+S:	Maintained
+F:	drivers/iommu/exynos-iommu.c
+
 EXYNOS MIPI DISPLAY DRIVERS
 M:	Inki Dae <inki.dae@samsung.com>
 M:	Donghwa Lee <dh09.lee@samsung.com>
-- 
1.9.2
