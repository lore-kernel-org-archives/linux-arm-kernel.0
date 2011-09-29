From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 16:24:22 +0900
Subject: [PATCH 0/2] ARM: EXYNOS4: Add support for MCT PPI
Message-ID: <008e01cc7e78$cf8e8160$6eab8420$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is required to support upcoming Samsung SoCs.

Current MCT can support only SPI for local timers but upcoming EXYNOS SoCs
doesn't have SPI for local timers.

NOTE:
This patches will not work with Marc Zyngier's "ARM: gic: consolidate
PPI handling". It means if his patch is applied, this should be dropped
and re-worked.

[PATCH 1/2] ARM: EXYNOS4: Add support PPI in external GIC
[PATCH 2/2] ARM: EXYNOS4: Add support MCT PPI for EXYNOS4212

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
