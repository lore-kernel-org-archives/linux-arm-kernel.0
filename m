From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Mar 2012 14:56:01 +0530
Subject: [PATCH 0/4] ARM: Exynos: Fixes for Exynos5 device tree support
Message-ID: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes general fixes for Exynos5 device tree support. This
is based on the following tree. Both Exynos4 and Exynos5 device tree
support have been tested when this series.

http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]


Thomas Abraham (4):
  ARM: Exynos: Use CHIP_ID to detect cpu type during decompression setup
  ARM: Exynos: Remove a new bus_type instance for Exynos5
  ARM: Exynos5: Fix incorrect initialization of GIC
  ARM: Exynos5: Add PDMA and MDMA physical base address defines

 arch/arm/mach-exynos/common.c                  |   21 +++------------------
 arch/arm/mach-exynos/include/mach/map.h        |    5 +++++
 arch/arm/mach-exynos/include/mach/uncompress.h |    6 +++++-
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    3 ++-
 4 files changed, 15 insertions(+), 20 deletions(-)
