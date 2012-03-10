From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 02:19:04 -0800
Subject: [PATCH 0/5] ARM: EXYNOS: update clock part for new EXYNOS SoC
Message-ID: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches are splited out as per Olof's suggestion.

And this series is including following:

- move mach-exynos/clock.c to mach-exynos/clock-exynos4.c
- according to moving clock-exynos4.c,
  move <mach/exynos4-clock.h> to "clock-exynos4.h"
- the prefix of clk register replace S5P_ with EXYNOS4_
- add prefix exynos4_ on clk declaration
- add clock registers for exynos4x12-cpufreq

[PATCH 1/5] ARM: EXYNOS: replace clock.c for other new EXYNOS SoCs
[PATCH 2/5] ARM: EXYNOS: use static declaration on regarding clock
[PATCH 3/5] ARM: EXYNOS: change the prefix S5P_ to EXYNOS4_ for
[PATCH 4/5] PM / devfreq: update the name of EXYNOS clock register
[PATCH 5/5] ARM: EXYNOS: add clock registers for exynos4x12-cpufreq
