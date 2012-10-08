From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 15:02:21 +0200
Subject: [PATCH 0/4] ARM: EXYNOS: Kconfig cleanup
Message-ID: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series aims to consolidate low level Kconfig entries for Exynos
SoC series by adding missing or removing wrong dependencies, renaming
entries to match a single naming convention and introducing a common
parent entry for EXYNOS4212 and EXYNOS4412.

See particular patches for more detailed descriptions.

Tomasz Figa (4):
  ARM: EXYNOS: Kconfig: Rename CPU_EXYNOS4210 to SOC_EXYNOS4210
  ARM: EXYNOS: Kconfig: Sort out dependencies between options
  ARM: EXYNOS: Kconfig: Group EXYNOS{4212,4412} into EXYNOS4X12
  ARM: EXYNOS: Kconfig: Remove dependencies on particular SoCs from DT
    machines

 arch/arm/mach-exynos/Kconfig             | 42 +++++++++++++++-----------------
 arch/arm/mach-exynos/Makefile            |  4 +--
 arch/arm/mach-exynos/common.h            |  4 +--
 arch/arm/plat-samsung/include/plat/cpu.h |  2 +-
 drivers/cpufreq/Kconfig.arm              |  4 +--
 drivers/devfreq/Kconfig                  |  2 +-
 drivers/mmc/host/sdhci-s3c.c             |  2 +-
 drivers/tty/serial/samsung.c             |  3 +--
 8 files changed, 30 insertions(+), 33 deletions(-)

-- 
1.7.12
