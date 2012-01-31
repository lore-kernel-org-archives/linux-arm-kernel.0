From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 13:49:22 +0900
Subject: [PATCH 0/3] ARM: EXYNOS: cleanup clock part
Message-ID: <1327985365-7070-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically, this patch changes the clock.c in mach-exynos/ to
clock-exynos4.c at the same directory and this is neeed to
support for new EXYNOS SoC, and the prefix of the clk register
from S5P_ to EXYNOS4_ to use it clearly.

[PATCH 1/3] ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs
[PATCH 2/3] [CPUFREQ] EXYNOS4210: update the name of EXYNOS clock
[PATCH 3/3] PM / devfreq: update the name of EXYNOS clock register
