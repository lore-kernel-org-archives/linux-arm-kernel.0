From: arun.kk@samsung.com (Arun Kumar K)
Date: Fri,  6 Dec 2013 15:18:01 +0530
Subject: [PATCH 0/3] Exynos5420 Cpufreq support
Message-ID: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series adds the cpufreq driver for exynos5420 with
its dependencies. This initial version of the driver only
modifies the A15 core frequencies.

Arjun.K.V (1):
  cpufreq: exynos: Add exynos5420 cpufreq driver

Arun Kumar K (2):
  ARM: EXYNOS: Add exynos5 CPU clock divider offsets
  clk: exynos5420: Add alias names for cpu clocks

 arch/arm/mach-exynos/include/mach/regs-clock.h |   24 ++
 drivers/clk/samsung/clk-exynos5420.c           |    9 +-
 drivers/cpufreq/Kconfig.arm                    |   11 +
 drivers/cpufreq/Makefile                       |    1 +
 drivers/cpufreq/exynos-cpufreq.c               |    2 +
 drivers/cpufreq/exynos-cpufreq.h               |    8 +
 drivers/cpufreq/exynos5420-cpufreq.c           |  346 ++++++++++++++++++++++++
 7 files changed, 397 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cpufreq/exynos5420-cpufreq.c

-- 
1.7.9.5
