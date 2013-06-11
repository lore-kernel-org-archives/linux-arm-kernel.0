From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Jun 2013 17:33:33 +0900
Subject: About LPAE supporting on EXYNOS5440
Message-ID: <109e01ce667e$5becc880$13c65980$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The exynos5440 can support LPAE and referece boards, SSDK5440 and SD5v1 have
over 8GiB memory.

Current exynos_defconfig selects every EXYNOS SoCs including exynos5440 it
means supporting LPAE will be selected for other EXYNOS SoCs.

I'm wondering if seleting LPAE causes some problem for multiplatform. Can we
support LPAE enabled and disabled platform together with single zImage?

Thanks,
Kukjin
