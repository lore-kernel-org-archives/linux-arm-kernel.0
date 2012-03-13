From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Mar 2012 08:30:31 -0700
Subject: [PATCH v3 00/12] ARM: EXYNOS: add support new EXYNOS5250
Message-ID: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support EXYNOS5250 SoC which has two A15 cores
can be used on mobile and tablet devices.

Changes since v2:
- update interrupt number declaration for single zImage
  of exynos4 and exynos5
- allow to select for exynos4 and exynos5 together
- add support EINT for exynos4 and exynos5
- add l2 cache initializer for exynos5250

Changes since v1:
- address comments from mailing list
- update the option accordingly common.[ch]
- update clock part
- get rid of static mapping for uart
- add device tree enabled board file(mach-exynos5-dt.c)
- add initial dts file for EXYNOS5250(SoC), SMDK5250(Board)

[PATCH v3 01/12] ARM: EXYNOS: to declare static for mach-exynos/common.c
[PATCH v3 02/12] ARM: EXYNOS: use exynos_init_uarts() instead of exynos4_init_uarts()
[PATCH v3 03/12] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
[PATCH v3 04/12] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
[PATCH v3 05/12] ARM: EXYNOS: add support uart for EXYNOS4 and EXYNOS5
[PATCH v3 06/12] ARM: EXYNOS: add support for EXYNOS5250 SoC
[PATCH v3 07/12] ARM: EXYNOS: add interrupt definitions for EXYNOS5250
[PATCH v3 08/12] ARM: EXYNOS: support EINT for EXYNOS4 and EXYNOS5
[PATCH v3 09/12] ARM: EXYNOS: add support get_core_count() for EXYNOS5250
[PATCH v3 10/12] ARM: EXYNOS: add support ARCH_EXYNOS5 for EXYNOS5 SoCs
[PATCH v3 11/12] ARM: EXYNOS: add support device tree enabled board file for EXYNOS5
[PATCH v3 12/12] ARM: dts: add initial dts file for EXYNOS5250, SMDK5250
